class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def sample_email
        @user = User.last
        email = "taromka10@gmail.com"
        puts(mail(to: email, subject: "Welcome to Plant-Clinique"))
    end
end
