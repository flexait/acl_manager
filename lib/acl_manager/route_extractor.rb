require 'action_dispatch/routing/inspector'

module AclManager
  class RouteExtractor
    def all
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
      inspector.format(array_formatter_instance)
    end

    private

    def array_formatter_instance
      AclManager::Routing::ArrayFormatter.new
    end

    def all_routes
      Rails.application.routes.routes
    end
  end
end
