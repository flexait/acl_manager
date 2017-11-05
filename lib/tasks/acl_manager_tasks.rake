# desc "Explaining what the task does"
# task :acl_manager do
#   # Task goes here
# end

namespace :acl_manager do

  desc 'Allows user to create role. Usage: app:acl_manager:create_role with role params'
  task :create_role => :environment do |task, args|
    name = ENV['name'] || 'admin'
    active = ENV['active'].present? ? true?(ENV['active']) : true
    description = ENV['description'] || 'gives users admin access'

    role = AclManager::Role.create(name: name, active: active, description: description)
    role.acls << AclManager::Acl.first
    user = User.first
    user.roles << role
    user.save!

    puts "Role with id #{role.id} was created."
  end

  # Convert to boolean
  def true?(obj)
    obj.to_s == "true"
  end
end
