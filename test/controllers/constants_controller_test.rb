require "test_helper"

class ConstantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @constant = constants(:one)
  end

  test "should get index" do
    get constants_url
    assert_response :success
  end

  test "should get new" do
    get new_constant_url
    assert_response :success
  end

  test "should create constant" do
    assert_difference("Constant.count") do
      post constants_url, params: { constant: {
        patient_id: @constant.patient_id,
        constant_type_id: @constant.constant_type_id,
        value: @constant.value,
        date: "2023-10-27",
        time: "10:00"
      } }
    end

    assert_redirected_to constants_path
  end

  test "should get new as turbo stream" do
    get new_constant_url, headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html", @response.media_type
  end

  test "should re-render form as turbo stream on create failure" do
    assert_no_difference("Constant.count") do
      post constants_url, params: { constant: { value: nil } }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end

    assert_response :success
    assert_includes @response.body, "turbo-stream"
    assert_includes @response.body, "constant_form"
  end

  test "should show constant" do
    get constant_url(@constant)
    assert_response :success
  end

  test "should get edit" do
    get edit_constant_url(@constant)
    assert_response :success
  end

  test "should update constant" do
    patch constant_url(@constant), params: { constant: { value: 120.0 } }
    assert_redirected_to root_path
  end

  test "should destroy constant" do
    assert_difference("Constant.count", -1) do
      delete constant_url(@constant)
    end

    assert_redirected_to root_path
  end
end
