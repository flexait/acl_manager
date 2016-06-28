module AclManager
  class Filter
    class << self
      def before(controller, resource)
        @controller = controller
        @resource = resource
        block_access! unless permit!
      end

      private

      def block_access!
        @controller.render :file => 'public/401.html', :status => :unauthorized
      end

      def permit!
        acl = find_acl
        acl.nil? || @resource.permit!(acl)
      end

      def find_acl
        AclManager::Acl.find_by(find_route)
      end

      def find_route
        {namespace: namespace, controller: @controller.controller_name, action: @controller.action_name}
      end

      def namespace
        path = @controller.controller_path
        return 'none' unless path.include?('/')
        path.split('/').first
      end
    end
  end
end
