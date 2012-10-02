# Include hook code here
require 'role_on_rails/role_on_rails'

ActiveRecord::Base.class_eval { include RoleOnRails }

module RoleOnRails
  class Engine < Rails::Engine
  end if defined?(Rails) && Rails::VERSION::MAJOR == 3
end

