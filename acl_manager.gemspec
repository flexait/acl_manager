$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acl_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acl_manager"
  s.version     = AclManager::VERSION
  s.authors     = ["Gil Gomes", "Denilson Silva"]
  s.email       = ["gilgomesp@gmail.com", "denilson.silva@flexait.com.br"]
  s.homepage    = "https://github.com/flexait/acl_manager"
  s.summary     = "Summary of AclManager."
  s.description = "Access Control List."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.2.x"
  s.add_dependency "awesome_nested_set"
  s.add_dependency "devise"
  s.add_development_dependency "sqlite3"
end
