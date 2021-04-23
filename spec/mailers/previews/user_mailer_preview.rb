# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def sample_email
        reminder = Reminder.all.sample
        UserMailer.with(reminder: reminder).sample_email
    end
end
