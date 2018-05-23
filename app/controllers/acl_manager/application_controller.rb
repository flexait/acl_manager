module AclManager
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!, :authorizate_user!
  end
end
