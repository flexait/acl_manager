require_dependency "acl_manager/application_controller"

module AclManager
  class AclsController < ApplicationController
    before_action :set_acl, only: [:show, :edit, :update, :destroy]

    def index
      @acls = Acl.all
    end

    def show; end

    def new
      @acl = Acl.new
    end

    def edit; end

    def create
      @acl = Acl.new(acl_params)

      if @acl.save
        redirect_to @acl, notice: t('notices.create', model: Acl.model_name.human)
      else
        render :new
      end
    end

    def update
      if @acl.update(acl_params)
        redirect_to @acl, notice: t('notices.update', model: Acl.model_name.human)
      else
        render :edit
      end
    end

    def destroy
      @acl.destroy
      redirect_to acls_url, notice: t('notices.destroy', model: Acl.model_name.human)
    end

    def build_all
      AclManager::Acl.build_all!
      flash[:notice] = t('notices.acl.build_all')
      redirect_to acls_path
    end

    private

    def set_acl
      @acl = Acl.find(params[:id])
    end

    def acl_params
      params.require(:acl).permit(:name, :namespace, :controller, :action, :verb, :helper, :path, :parent_id, :lft, :rgt)
    end
  end
end
