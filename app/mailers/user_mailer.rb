class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def sample_email
        @reminder = params[:reminder]
        email = "seciko8270@vreagles.com" # test email
        puts("on tick day", on_tick_day?)
        puts("already sent", already_sent?)
        puts("after tick time", after_tick_time?)

        # send email if on the correct day and after tick_time
        if on_tick_day? and already_sent? and after_tick_time?
            mail(to: email, subject: "Your Plant-Clinique's friendly reminder")
            # update email time
            @reminder.touch(:email_time)
        end
    end

    private

    def on_tick_day?
        return ((Time.now - @reminder.created_at) / 86400).floor.modulo(@reminder.interval) == 0
    end

    def already_sent?
        a = Time.now.year == @reminder.email_time.year
        b = Time.now.month == @reminder.email_time.month
        c = Time.now.day == @reminder.email_time.day
        a and b and c
    end

    def after_tick_time?
        return (Time.now.strftime("%H%M%S") > @reminder.tick_time.strftime("%H%M%S"))
    end
end
