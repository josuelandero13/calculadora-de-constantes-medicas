require "test_helper"

class ConstantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get constants_index_url
    assert_response :success
  end

  test "should get show" do
    get constants_show_url
    assert_response :success
  end

  test "should get new" do
    get constants_new_url
    assert_response :success
  end

  test "should get create" do
    get constants_create_url
    assert_response :success
  end

  test "should get edit" do
    get constants_edit_url
    assert_response :success
  end

  test "should get update" do
    get constants_update_url
    assert_response :success
  end

  test "should get destroy" do
    get constants_destroy_url
    assert_response :success
  end
end
