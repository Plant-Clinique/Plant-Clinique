require "application_system_test_case"

class UserPlantsTest < ApplicationSystemTestCase
  setup do
    @user_plant = user_plants(:one)
  end

  test "visiting the index" do
    visit user_plants_url
    assert_selector "h1", text: "User Plants"
  end

  test "creating a User plant" do
    visit user_plants_url
    click_on "New User Plant"

    fill_in "Age", with: @user_plant.age
    fill_in "Description", with: @user_plant.description
    fill_in "Img url", with: @user_plant.img_url
    fill_in "Name", with: @user_plant.name
    fill_in "Plant type", with: @user_plant.plant_type
    fill_in "User", with: @user_plant.user_id
    click_on "Create User plant"

    assert_text "User plant was successfully created"
    click_on "Back"
  end

  test "updating a User plant" do
    visit user_plants_url
    click_on "Edit", match: :first

    fill_in "Age", with: @user_plant.age
    fill_in "Description", with: @user_plant.description
    fill_in "Img url", with: @user_plant.img_url
    fill_in "Name", with: @user_plant.name
    fill_in "Plant type", with: @user_plant.plant_type
    fill_in "User", with: @user_plant.user_id
    click_on "Update User plant"

    assert_text "User plant was successfully updated"
    click_on "Back"
  end

  test "destroying a User plant" do
    visit user_plants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User plant was successfully destroyed"
  end
end
