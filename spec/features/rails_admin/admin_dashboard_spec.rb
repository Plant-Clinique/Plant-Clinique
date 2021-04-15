require "rails_helper"
RSpec.feature "Admin dashboard" do
  scenario "visitor is admin" do
    admin = create(:admin)

    visit rails_admin_path(as: admin)

    expect(page).to have_content("Site Administration")
  end

  scenario "visitor is not an admin user" do
    user = create(:user)

    visit rails_admin_path(as: user)

    expect(current_path).to eq "/users/#{user.id}"
  end
end