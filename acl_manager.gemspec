$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acl_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acl_manager"
  s.version     = AclManager::VERSION
  s.authors     = ["Gil"]
  s.email       = ["gil.gomes@flexait.com.br"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of AclManager."
  s.description = "TODO: Description of AclManager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "sqlite3"
end
