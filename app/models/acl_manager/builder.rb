module AclManager
  module Builder
    def build_all!
      @acls = []
      @all = AclManager::RouteExtractor.new.all
      @acls << Acl.root
      create_namespaces
      create_controllers
      create_acls
      Acl.where.not(id: @acls.map(&:id)).destroy_all
    end       

    private

    def create_namespaces
      @all[:namespaces].each do |namespace|
        @acls << Acl.find_or_create_by(name: namespace, namespace: namespace, parent: Acl.root)
      end
    end

    def create_controllers
      @all[:controllers].each do |route|
        parent = Acl.find_by(name: route[:namespace], namespace: route[:namespace]) || Acl.root
        @acls << Acl.find_or_create_by(name: controller_name(route), namespace: route[:namespace], 
          controller: route[:controller], parent: parent)
      end
    end

    def create_acls
      @all[:routes].each do |route|
        build!(route)
      end
    end

    def build! route
      db_route = Acl.find_by(namespace: route[:namespace], controller: route[:controller], action: route[:action])
      route[:parent] = Acl.find_by(name: controller_name(route), namespace: route[:namespace], controller: route[:controller]) || 
        Acl.root
      if db_route.nil?
        @acls << Acl.create(route)
      else
        db_route.update(route)
        @acls << db_route
      end
    end

    def controller_name route
      return "#{route[:namespace]}/#{route[:controller]}" unless route[:namespace].nil? || route[:namespace] == 'none'
      route[:controller]
    end
  end
end
