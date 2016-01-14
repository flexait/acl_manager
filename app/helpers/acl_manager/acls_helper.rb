module AclManager
  module AclsHelper
  	include ActionView::Helpers::UrlHelper

	  def link_to(*args, &block)
	    @last_param = args.last
	    if block_given?
	      options = args.first || {}
	      return default_name(args, capture(&block)) unless permit!(options)
	    else
	      options = args[1] || {}
	      return default_name(args, args.first) unless permit!(options)
	    end

	    super
	  end

	  def permit! options, last_param = nil
	    @options = options
	    @last_param = last_param unless last_param.nil?
	    current_user.nil? || black_listed? || current_user.permit!(find_acl)
	  end

	  private

	  def current_user
	  	User.first
	  end

	  def default_name(args, name)
	    args.last.is_a?(Hash) && args.last[:show_name] ? 
	      content_tag(:a, name, args.last.reject { |key, value| key == :show_name }) : ''
	  end

	  def black_listed?
	    @last_param.is_a?(Hash) && @last_param[:no_acl]
	  end
	  
	  def find_acl
	    AclManager::Acl.find_by(find_route)
	  end

	  def find_route
	    method = {}
	    method = @last_param if @last_param.is_a?(Hash) && !@last_param[:method].nil?
	    url_path = "#{request.protocol}#{request.host}:#{request.port}#{url_for(@options)}"
	    AclManager::RouteExtractor::Recognizer.fullpath(url_path, method)
	  end
  end
end
