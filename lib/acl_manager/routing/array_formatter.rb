require 'action_dispatch/routing/inspector'

module AclManager
  module Routing
    class ArrayFormatter < ActionDispatch::Routing::ConsoleFormatter
      def initialize
        @routes = []
        @namespaces = []
        @controllers = []

        super
      end

      def result
        { routes: @routes, namespaces: @namespaces.uniq, controllers: @controllers.uniq }
      end

      def section(list)
        list.each do |route|
          reqs = extract(route[:reqs])
          next if reqs.nil?
          @namespaces << reqs[:namespace]
          @controllers << {namespace: reqs[:namespace], controller: reqs[:controller]}
          @routes << normalize(route, reqs)
        end
      end

      private

      def normalize(route, reqs)
        route[:helper] = route[:name]
        route[:name] = route[:reqs]
        route.delete(:reqs)
        route.delete(:regexp)
        route.merge(reqs)
      end

      def extract(reqs)
        return {namespace: reqs} if reqs.include?("::")
        return if reqs == 'redirect(301)'
        regex = /(?:(?<namespace>.*)\/)?(?<controller>.+)\#(?<action>[^\s]*)(.+)?/.match(reqs)
        {namespace: regex[:namespace] || 'none', controller: regex[:controller], action: regex[:action]}
      end
    end
  end
end
