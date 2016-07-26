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

      private

      def model_exists?
        File.exist?(File.join(destination_root, model_path))
      end

      def migration_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_acl_manager_to_#{table_name}.rb$/).first
      end

      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

    end
  end
end
