require 'rails/generators/named_base'
require 'rails/generators/active_record'


module AclManager
  module Generators
    class AclManagerGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: "field:type field:type"
      source_root File.expand_path('../templates', __FILE__)

      def copy_acl_manager_migration
        migration_template "migration.rb",
        "db/migrate/add_acl_manager_to_#{table_name}.rb",
        migration_number: migration_number
      end
    end
  end
end
