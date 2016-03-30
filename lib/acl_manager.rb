require "acl_manager/engine"
require "acl_manager/builder"
require "acl_manager/filter"
require "acl_manager/route_extractor"
require "acl_manager/permissions"
require "acl_manager/relationships"

module AclManager
end

Devise.add_module(:acl_manager, model: 'acl_manager/model')
