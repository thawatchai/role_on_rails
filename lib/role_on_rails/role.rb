module RoleOnRails
  module Role
    attr_reader :id, :name, :symbol, :assignable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      mattr_accessor :roles

      def ids_for(symbols)
        symbols = [symbols].compact unless symbols.is_a?(Array)
        symbols.map(&:to_sym).inject([]) do |result, symbol|
          role = @@roles.rassoc(symbol)
          result << role[0] unless role.nil?
          result
        end
      end

      def define_role(symbol, id = nil, name = nil, assignable = true)
        @@roles ||= []
        @@roles << [id || @@roles.size + 1, symbol, name || Proc.new(I18n.t("roles.names.#{symbol}")), assignable]
      end

      def list
        @@roles.map { |r| self.new(r[0]) }
      end

      def assignable_list
        @@roles.select { |r| r[3].is_a?(Proc) ? r[3].call : r[3] }.map { |r| self.new(r[0]) }
      end
    end

    def initialize(id)
      row = self.class.roles.assoc(id.to_i)
      @id, @symbol, @name, @assignable = row if row
    end
  end
end

