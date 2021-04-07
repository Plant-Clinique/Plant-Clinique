module Features
  module ClearanceHelpers

    def sign_in
      username = "someone"
      password = "password"
      user = FactoryBot.create(:user, username: username, password: password)
      sign_in_with user.email, password
    end

    def sign_in_with(email, password)
      visit sign_in_path
      fill_in "session_email", with: email
      fill_in "session_password", with: password
      find('[type=submit]').click
    end

    def sign_out
      find('[href="/sign_out"]').click
    end

    def sign_up_with(email, username, password)
      visit sign_up_path
      fill_in "user_username", with:username
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      find(:xpath,"/html/body/div[1]/div/div/div[2]/form/div[4]/div/input").click
    end

    def expect_user_to_be_signed_in
      expect(page).to have_content("Sign out")
    end

    def expect_user_to_be_signed_out
      expect(page).to have_content("Sign in")
    end

  end
end

RSpec.configure do |config|
  config.include Features::ClearanceHelpers, type: :feature
end
