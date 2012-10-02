role_on_rails
=============

Basic role gem

Installation
------------

Add the following to your Gemfile:

    gem 'role_on_rails', :git => 'http://github.com/zonecheung/role_on_rails.git'
  
Then run the generator to create migration files:

    rails g role_on_rails:install

Define the roles by adding `app/models/role.rb`:

    class Role
      include RoleOnRails::Role
      
      # define_role(name, id, title, assignable)
      # name       => symbol,  name of the role
      # id         => integer, id of the role, this should NOT be changed after role is assigned.
      # title      => string,  the string to represent the role in UI
      # assignable => boolean, whether this role should be included as options for selection in the UI.

      define_role :teaching_assistant,              1, I18n.t("admin.roles.names.teaching_assistant"), false
      define_role :public_discussion_administrator, 2, I18n.t("admin.roles.names.public_discussion_administrator")
      define_role :teacher,                         3, I18n.t("admin.roles.names.teacher"), false
      define_role :student,                         4, I18n.t("admin.roles.names.student"), false
    end

And add a line in your `app/models/user.rb`:

    class User < ActiveRecord::Base
      role_subject
    end


Methods
-------

The following methods will be added to your `Role` class:

    Role.ids_for([:teacher, :student])  # => [3,4]
    Role.list                           # => Array of defined roles.
    Role.assignable_list                # => Array of roles with assignable = true.
  
And in your `User` class:

    user = User.find(123)
    course = Course.find(456)

    user.add_role(:teacher, course)
    user.has_role?(:teacher)            # => false
    user.has_role?(:teacher, course)    # => true

    user.remove_role(:teacher, course)
    user.has_role?(:teacher, course)    # => false

