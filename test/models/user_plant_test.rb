require "test_helper"

class UserPlantTest < ActiveSupport::TestCase
  def setup
    User.create!(username: "one", email: "two@one.com", password:"three")
    @user_plant= UserPlant.new(name: "Example Plant", user_id: User.first.id, age: 1)
  end
  test "should be valid" do
    assert @user_plant.valid?
  end
  test "name should be present" do
    @user_plant.name = "     "
    assert_not @user_plant.valid?
  end
  test "age should be present" do
    @user_plant.age = "     "
    assert_not @user_plant.valid?
  end
  test "name should not be longer than 100 characters" do
    @user_plant.name = "a" * 105
    assert_not @user_plant.valid?
  end
end
