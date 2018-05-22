require_dependency "acl_manager/application_controller"

module AclManager
  class RolesController < ApplicationController
    before_action :set_role, only: [:show, :edit, :update, :destroy]
    before_action :set_acls, only: [:new, :edit]

    def index
      @roles = Role.unscoped.all
    end

    def show; end

    def new
      @role = Role.new
    end

    def edit; end

    def create
      @role = Role.new(role_params)

      if @role.save
        redirect_to @role, notice: t('notices.create', model: Role.model_name.human)
      else
        render :new
      end
    end

    def update
      if @role.update(role_params)
        redirect_to @role, notice: t('notices.update', model: Role.model_name.human)
      else
        render :edit
      end
    end

    def destroy
      @role.destroy
      redirect_to roles_url, notice: t('notices.destroy', model: Role.model_name.human)
    end

    private

    def set_acls
      @acls = Acl.root_and_descendents
    end

    def set_role
      @role = Role.unscoped.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :active, { acl_ids: [] })
    end
  end
end
