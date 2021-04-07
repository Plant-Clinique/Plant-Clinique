require "test_helper"

class ReminderTest < ActiveSupport::TestCase
  def setup
    User.create!(username: "one", email: "two@one.com", password:"three")
    UserPlant.create!(name: "Example Plant", user_id: User.first.id, age: 1)
    @reminder= Reminder.new(user_plant_id: UserPlant.first.id, user_id: User.first.id, reminder_time: Time.now)
  end
  test "should be valid" do
    assert @reminder.valid?
  end
  test "time should be present" do
    @reminder.reminder_time = ""
    assert_not @reminder.valid?
  end
  test "description doesn't have to be present" do
    assert @reminder.valid?
  end
end
