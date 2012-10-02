require 'role_on_rails/role_subject'
require 'role_on_rails/role_context'

module RoleOnRails

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def role_subject(options = {})
      cattr_reader :role_klass
      has_many :role_assignments, :dependent => :destroy
      include RoleOnRails::RoleSubject::InstanceMethods
      extend RoleOnRails::RoleSubject::SingletonMethods
      class_variable_set(:@@role_klass, options[:class] || ::Role)
    end

    def role_context(options = {})
      cattr_reader :role_klass
      belongs_to :role_assignment, :as => :context, :dependent => :destroy
      include RoleOnRails::RoleContext::InstanceMethods
      extend RoleOnRails::RoleContext::SingletonMethods
      class_variable_set(:@@role_klass, options[:class] || ::Role)
    end
  end

end

