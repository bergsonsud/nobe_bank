require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get account_new_url
    assert_response :success
  end

  test "should get create" do
    get account_create_url
    assert_response :success
  end

  test "should get update" do
    get account_update_url
    assert_response :success
  end

  test "should get swtich" do
    get account_swtich_url
    assert_response :success
  end

end
