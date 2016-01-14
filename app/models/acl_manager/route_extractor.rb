module AclManager
  require 'action_dispatch/routing/inspector'
  
  class RouteExtractor    
    attr_reader :all

    def initialize
      all_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
      @all = inspector.format(ArrayFormatter.new)
    end

    private

    class ArrayFormatter < ActionDispatch::Routing::ConsoleFormatter
      def initialize
        super
        @routes = []
        @namespaces = []
        @controllers = []
        @routes = []
      end

      def result
        {routes: @routes, namespaces: @namespaces.uniq, controllers: @controllers.uniq}
      end

      def section(list)
        list.each do |route|
          reqs = extract(route[:reqs])
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
        regex = /(?:(?<namespace>.*)\/)?(?<controller>.+)\#(?<action>[^\s]*)(.+)?/.match(reqs)
        {namespace: regex[:namespace] || 'none', controller: regex[:controller], action: regex[:action]}
      end
    end

    class Recognizer
      def self.fullpath url_path, options
        raise 'Bad link_to usage. You don\'t need href with no URL. Remove it.' if url_path.include?('javascript:')

        route = find(url_path, options)
        path = route[:controller].include?('/') ? route[:controller].split('/') : ['none', route[:controller]]

        {namespace: path.first, controller: path.last, action: route[:action]}
      end

      private

      def self.find(path, options)
        begin
          recognized_path = Rails.application.routes.recognize_path(path, options)
        rescue ActionController::RoutingError
          Rails::Engine.subclasses.each do |engine|
            engine_instance = engine.instance
            engine_class = engine_instance.class

            route = all.find do |r|
              r[:namespace] == engine.name
            end

            engine_path = path.gsub(route[:path], '')

            begin
              recognized_path = engine_instance.routes.recognize_path(engine_path, options)
            rescue ActionController::RoutingError => e
              Rails.logger.debug "[#{engine}] ActionController::RoutingError: #{e.message}"
            end
          end

          recognized_path
        end
      end

      def self.all
        @@all ||= RouteExtractor.new.all[:routes]
      end
    end
  end
end
