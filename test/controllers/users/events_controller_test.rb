require 'test_helper'

class Users::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_events_new_url
    assert_response :success
  end

  test "should get show" do
    get users_events_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_events_edit_url
    assert_response :success
  end

  test "should get my_calendar" do
    get users_events_my_calendar_url
    assert_response :success
  end

end
