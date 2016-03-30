module Devise
  module Models
    module AclManager
      extend ActiveSupport::Concern

      included do
        include ::AclManager::Permissions
        include ::AclManager::Relationships
      end
    end
  end
end
