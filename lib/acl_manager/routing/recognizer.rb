require 'action_dispatch/routing/inspector'

module AclManager
  module Routing
    class Recognizer
      def self.fullpath(url_path, options)
        new(url_path, options).fullpath
      end

      def initialize(url_path, options)
        @url_path = url_path
        @options  = options
      end

      def fullṕath
        raise 'Bad link_to usage. You don\'t need href with no URL. Remove it.' if @url_path.include?('javascript:')

        route = find(@url_path, @options)
        path = route[:controller].include?('/') && !route[:controller].include?('rails/') ? route[:controller].split('/') : ['none', route[:controller].gsub('rails/', '')]

        {namespace: path.first, controller: path.last, action: route[:action]}
      end

      private

      def find
        begin
          recognized_path = find_on_rails_app
        rescue ActionController::RoutingError
          Rails::Engine.subclasses.each do |engine|
            begin
              recognized_path = find_on_engine(engine)
            rescue ActionController::RoutingError
              next
            end
          end
        end

        recognized_path.blank? ? {controller: @url_path} : recognized_path
      end

      def find_on_engine(engine)
        engine.routes.recognize_path($1, @options) if valid_route?
      end

      def valid_route?
        engine_name = engine.name.split("::").first.underscore
        route = all.find{ |r| r[:namespace] == engine_name }

        route.present? && @url_path.gsub(route[:path], '').match(/#{engine_name}(\/.*)/)
      end

      def find_on_rails_app
        Rails.application.routes.recognize_path(@url_path, @options)
      end

      def all
        @@all ||= AclManager::RouteExtractor.new.all[:routes]
      end
    end
  end
end
