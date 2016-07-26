require 'test_helper'
require 'generators/acl_manager/acl_manager_generator'

module AclManager
  class AclManagerGeneratorTest < Rails::Generators::TestCase
    tests AclManagerGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
