# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "role_on_rails/version"

Gem::Specification.new do |s|
  s.name        = "role_on_rails"
  s.version     = RoleOnRails::VERSION
  s.platform    = Gem::Platform::RUBY  
  s.summary     = "Basic role functionalities."
  s.email       = "zonecheung@gmail.com"
  s.homepage    = "http://github.com/thawatchai/role_on_rails"
  s.description = "Basic role functionalities."
  s.authors     = ['John Tjanaka']

  s.rubyforge_project = "role_on_rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("rails", "~> 4.2")
end
