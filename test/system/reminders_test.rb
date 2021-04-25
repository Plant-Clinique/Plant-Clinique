require "application_system_test_case"

class RemindersTest < ApplicationSystemTestCase
  setup do
    @reminder = reminders(:one)
  end

  test "visiting the index" do
    visit reminders_url
    assert_selector "h1", text: "Reminders"
  end

  test "creating a Reminder" do
    visit reminders_url
    click_on "New Reminder"

    fill_in "Description", with: @reminder.description
    fill_in "Tick time", with: @reminder.tick_time
    fill_in "Interval", with: @reminder.interval
    fill_in "Type", with: @reminder.type
    fill_in "User", with: @reminder.user_id
    fill_in "User plant", with: @reminder.user_plant_id
    click_on "Create Reminder"

    assert_text "Reminder was successfully created"
    click_on "Back"
  end

  test "updating a Reminder" do
    visit reminders_url
    click_on "Edit", match: :first

    fill_in "Description", with: @reminder.description
    fill_in "Tick time", with: @reminder.tick_time
    fill_in "Interval", with: @reminder.interval
    fill_in "Type", with: @reminder.type
    fill_in "User", with: @reminder.user_id
    fill_in "User plant", with: @reminder.user_plant_id
    click_on "Update Reminder"

    assert_text "Reminder was successfully updated"
    click_on "Back"
  end

  test "destroying a Reminder" do
    visit reminders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reminder was successfully destroyed"
  end
end
