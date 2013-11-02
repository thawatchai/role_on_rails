class RoleAssignment < ActiveRecord::Base
  #attr_accessible :user_id, :role_id, :disabled, :context_id, :context_type,
  #                :user, :context

  belongs_to :user
  belongs_to :context, :polymorphic => true

  validates :user, :presence => true
  validates :role_id, :presence => true
  validates :context, :presence => true, :if => Proc.new { |r| r.context_type.present? }

  def self.has?(user, symbols, context = nil)
    symbols = [symbols] unless symbols.is_a?(Array)

    symbols.any? do |s|
      key = context.blank? ? "#{s}:#{user.id}" :
              "#{s}:#{user.id}:#{context.class.to_s.parameterize}:#{context.id}"
      value = Rails.cache.read(key)

      if value.nil?
        role_ids = user.role_klass.ids_for(s)
        conditions = { :role_id => role_ids }
        conditions.merge!(
          context.nil? ?
            { :context_type => nil, :context_id => nil } :
            { :context_type => context.class.to_s, :context_id => context.id }
        )
        value = !! (role_ids.present? && 
                    user.role_assignments.where(conditions).exists?)
        Rails.cache.write(key, value)
      end
      value
    end
  end

  def self.clear_cache(user, symbols, context = nil)
    symbols = [symbols] unless symbols.is_a?(Array)

    symbols.each do |s|
      key = context.blank? ? "#{s}:#{user.id}" :
              "#{s}:#{user.id}:#{context.class.to_s.parameterize}:#{context.id}"
      Rails.cache.delete(key)
    end    
  end
end

