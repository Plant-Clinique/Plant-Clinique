class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_1"
  end
end
