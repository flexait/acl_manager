module AclManager
  class Filter
    class << self
      def before(controller)
        @controller = controller
        block_access! unless permit!
      end

      private
      
      def block_access!
        @controller.render :file => 'public/401.html', :status => :unauthorized
      end

      def permit!
        acl = find_acl
        return true if acl.nil?
        @controller.current_user.permit!(acl)
      end

      def find_acl
        AclManager::Acl.find_by(find_route)
      end

      def find_route
        {namespace: namespace, controller: @controller.controller_name, action: @controller.action_name}
      end

      def namespace
        @controller.controller_path.split('/').first
      end
    end
  end
end
