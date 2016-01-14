module AclManager
  class ApplicationController < ActionController::Base
    before_filter AclManager::Filter
  end
end
