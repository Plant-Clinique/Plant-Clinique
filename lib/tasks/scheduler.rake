desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end

task :send_email => :environment do
  puts "Sending email..."
  UserMailer.with(user: User.first).sample_email.deliver_now()
  puts "Done!"
end

task :send_reminders => :environment do
  User.send_reminders
end