require 'rails_helper'

RSpec.describe "acl_manager/roles/index", type: :view do
  before(:each) do
    assign(:roles, [
      AclManager::Role.create!(
        :name => "Role1"
      ),
      AclManager::Role.create!(
        :name => "Role2"
      )
    ])
  end

  it "render a list of roles" do
    render
    assert_select "h2.post-title", :text => "Role1".to_s, :count => 1
    assert_select "h2.post-title", :text => "Role2".to_s, :count => 1
  end
end
