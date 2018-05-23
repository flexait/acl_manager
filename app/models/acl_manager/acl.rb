require_dependency "acl_manager/builder"

module AclManager
  class Acl < ActiveRecord::Base
   extend AclManager::Builder

    acts_as_nested_set
    has_and_belongs_to_many :roles, class_name: AclManager::Role.name,
      join_table: 'acl_manager_acls_roles',
      foreign_key: 'acl_manager_acl_id',
      association_foreign_key: 'acl_manager_role_id'

    validates :action, uniqueness: {scope: [:namespace, :controller]}
    validates :name, uniqueness: true

    scope :inner_node, ->(acl){ where('lft <= ?', acl.lft).where('rgt >= ?', acl.rgt) }
    scope :outter_nodes, ->(acl){ where('lft >= ?', acl.lft).where('rgt <= ?', acl.rgt) }

    def self.permit!(acl)
      if(acl.nil?)
        Rails.logger.warn '[AclManager] Acl is nil for permission'
        true
      else
        inner_node(acl).limit(1).any?
      end
    end

    def included? role
      role_ids.include?(role.id)
    end

    class << self
      def root
        find_or_create_by(name: '*')
      end

      def root_and_descendents
        root.self_and_descendants
      end
    end
  end
end
