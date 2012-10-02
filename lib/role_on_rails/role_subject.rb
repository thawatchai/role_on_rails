require 'role_on_rails/role'

module RoleOnRails
  module RoleSubject
    module SingletonMethods
    end

    module InstanceMethods
      def has_role?(symbols, context = nil)
        RoleAssignment.has?(self, symbols, context)
      end

      def add_role(symbol, context = nil)
        RoleAssignment.clear_cache(self, symbol, context)
        role_id = self.class.role_klass.ids_for(symbol).first
        RoleAssignment.find_or_create_by_role_id_and_user_id_and_context_type_and_context_id(
          :role_id      => role_id,
          :user_id      => self.id,
          :context_type => context && context.class.to_s,
          :context_id   => context && context.id
        ) unless role_id.nil?
      end

      def remove_role(symbol, context = nil)
        RoleAssignment.clear_cache(self, symbol, context)
        role_id = self.class.role_klass.ids_for(symbol).first
        unless role_id.nil?
          role_assignment = context.nil? ?
            self.role_assignments.find_by_role_id(role_id) :
            self.role_assignments.find_by_role_id_and_context_type_and_context_id(role_id, context.class.to_s, context.id)
          role_assignment.destroy unless role_assignment.nil?
        end
      end
    end
  end
end

