require_dependency "acl_manager/application_controller"

module AclManager
  class RolesController < ApplicationController
    before_action :set_role, only: [:show, :edit, :update, :destroy]
    before_action :set_acls, only: [:new, :edit]
    # GET /roles
    def index
      @roles = Role.unscoped.all
    end

    # GET /roles/1
    def show
    end

    # GET /roles/new
    def new
      @role = Role.new
    end

    # GET /roles/1/edit
    def edit
    end

    # POST /roles
    def create
      @role = Role.new(role_params)

      if @role.save
        redirect_to @role, notice: t('notices.create', model: Role.model_name.human)
      else
        render :new
      end
    end

    # PATCH/PUT /roles/1
    def update
      if @role.update(role_params)
        redirect_to @role, notice: t('notices.update', model: Role.model_name.human)
      else
        render :edit
      end
    end

    # DELETE /roles/1
    def destroy
      @Role.destroy
      redirect_to roles_url, notice: t('notices.destroy', model: Role.model_name.human)
    end

    private

    def set_acls
      @acls = Acl.root_and_descendents
    end


      # Use callbacks to share common setup or constraints between actions.
      def set_role
        @role = Role.unscoped.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def role_params
        params.require(:role).permit(:name, :active, { acl_ids: [] })
      end
  end
end
