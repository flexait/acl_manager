require 'test_helper'

module AclManager
  class AclsControllerTest < ActionController::TestCase
    setup do
      @acl = acl_manager_acls(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:acls)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create acl" do
      assert_difference('Acl.count') do
        post :create, acl: { action: @acl.action, controller: @acl.controller, helper: @acl.helper, name: @acl.name, namespace: @acl.namespace, parent_id: @acl.parent_id, path: @acl.path, verb: @acl.verb }
      end

      assert_redirected_to acl_path(assigns(:acl))
    end

    test "should show acl" do
      get :show, id: @acl
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @acl
      assert_response :success
    end

    test "should update acl" do
      patch :update, id: @acl, acl: { action: @acl.action, controller: @acl.controller, helper: @acl.helper, name: @acl.name, namespace: @acl.namespace, parent_id: @acl.parent_id, path: @acl.path, verb: @acl.verb }
      assert_redirected_to acl_path(assigns(:acl))
    end

    test "should destroy acl" do
      assert_difference('Acl.count', -1) do
        delete :destroy, id: @acl
      end

      assert_redirected_to acls_path
    end
  end
end
