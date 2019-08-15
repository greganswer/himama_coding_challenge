require "application_system_test_case"

class ClockEventsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
  end

  test "visiting the index" do
    clock_events = create_list(:clock_event, 2, user: @user)
    visit clock_events_url
    assert_selector "h1", text: "Clock Events"
  
    # Verify that clock_events appears in listing
  end

  test "clocking in and out" do
    # Verify that clock_events are empty
    visit root_url
    click_on "Clock Events"
    within 'table' do
      refute_selector 'tr td.full_name', text: ''
    end

    # Clock in
    click_on "Home"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Clock In"
    assert_text "You're clocked in."

    # Verify that clock_events appears in listing
    clock_event = ClockEvent.first
    visit clock_events_url
    within 'table' do
      assert_selector 'tr td.full_name', text: @user.full_name
      assert_selector 'tr td.clock_in_at', text: clock_event.clock_in_at
      assert_selector 'tr td.clock_out_at', text: ''
    end

    # Clock out
    visit root_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Clock Out"
    assert_text "You've been clocked out."

    # Verify that clock_events appears in listing
    clock_event.reload
    visit clock_events_url
    within 'table' do
      assert_selector 'tr td.full_name', text: @user.full_name
      assert_selector 'tr td.clock_in_at', text: clock_event.clock_in_at
      assert_selector 'tr td.clock_out_at', text: clock_event.clock_out_at
    end
  end
end
