require 'test_helper'

class ClockEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clock_event = clock_events(:one)
  end

  test "should get index" do
    get clock_events_url
    assert_response :success
  end

  test "should get new" do
    get new_clock_event_url
    assert_response :success
  end

  test "should create clock_event" do
    assert_difference('ClockEvent.count') do
      post clock_events_url, params: { clock_event: { clock_in_at: @clock_event.clock_in_at, clock_out_at: @clock_event.clock_out_at } }
    end

    assert_redirected_to clock_event_url(ClockEvent.last)
  end

  test "should show clock_event" do
    get clock_event_url(@clock_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_clock_event_url(@clock_event)
    assert_response :success
  end

  test "should update clock_event" do
    patch clock_event_url(@clock_event), params: { clock_event: { clock_in_at: @clock_event.clock_in_at, clock_out_at: @clock_event.clock_out_at } }
    assert_redirected_to clock_event_url(@clock_event)
  end

  test "should destroy clock_event" do
    assert_difference('ClockEvent.count', -1) do
      delete clock_event_url(@clock_event)
    end

    assert_redirected_to clock_events_url
  end
end
