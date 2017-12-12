require 'test_helper'

class LivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @life = lives(:one)
  end

  test "should get index" do
    get lives_url
    assert_response :success
  end

  test "should get new" do
    get new_life_url
    assert_response :success
  end

  test "should create life" do
    assert_difference('Live.count') do
      post lives_url, params: { life: {  } }
    end

    assert_redirected_to life_url(Live.last)
  end

  test "should show life" do
    get life_url(@life)
    assert_response :success
  end

  test "should get edit" do
    get edit_life_url(@life)
    assert_response :success
  end

  test "should update life" do
    patch life_url(@life), params: { life: {  } }
    assert_redirected_to life_url(@life)
  end

  test "should destroy life" do
    assert_difference('Live.count', -1) do
      delete life_url(@life)
    end

    assert_redirected_to lives_url
  end
end
