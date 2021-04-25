desc "This task is called by the Heroku scheduler add-on"
# Example
task :update_feed => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end

# Send reminding email
task :send_email => :environment do
  puts "Starting email sending task"
  
  Reminder.all.each do |reminder|
    puts "Sending email"
    UserMailer.with(reminder: reminder).sample_email.deliver_now
    puts "Email sent"
  end
  puts "Done!"
end

# Example
task :send_reminders => :environment do
  User.send_reminders
end