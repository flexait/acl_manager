require 'action_dispatch/routing/inspector'

module AclManager
  module Routing
    class Recognizer
      def self.fullpath url_path, options
        raise 'Bad link_to usage. You don\'t need href with no URL. Remove it.' if url_path.include?('javascript:')

        route = find(url_path, options)
        Rails.logger.debug "[Route Extractor] #{route}"
        path = route[:controller].include?('/') && !route[:controller].include?('rails/') ? route[:controller].split('/') : ['none', route[:controller].gsub('rails/', '')]

        {namespace: path.first, controller: path.last, action: route[:action]}
      end

      private

      def self.find(path, options)
        begin
          Rails.logger.debug "[Route Extractor] Start #{path}"
          recognized_path = Rails.application.routes.recognize_path(path, options)
        rescue ActionController::RoutingError
          Rails::Engine.subclasses.each do |engine|
            begin
              engine_name = engine.name.split("::").first.underscore
              Rails.logger.debug "[Route Extractor] Try for engine #{engine_name}"

              route = all.find{ |r| r[:namespace] == engine_name }
              next if route.nil?
              engine_path = path.gsub(route[:path], '')

              if(engine_path.match(/#{engine_name}(\/.*)/))
                recognized_path = engine.routes.recognize_path($1, options)
              end
            rescue ActionController::RoutingError
              Rails.logger.debug "[Route Extractor][Error] No route found for #{path}"
            end
          end
        end
        Rails.logger.debug "[Route Extractor] Route found: #{recognized_path}"
        recognized_path.blank? ? {controller: path} : recognized_path
      end

      def self.all
        @@all ||= RouteExtractor.new.all[:routes]
      end
    end
  end
end
