class Reply < ApplicationRecord
    include CableReady::Broadcaster
    belongs_to :post
    belongs_to :user
    validates :body, presence: true

    after_commit :create_notifications, on: :create

    private

      def create_notifications
        Notification.create do |notification|
          notification.notify_type = 'post'
          notification.actor = self.user
          notification.user = User.find(self.post.user_id)
          notification.target = self
          notification.second_target = self.post
          cable_ready["notifications_#{notification.user.id}"].text_content(
            selector: "#notification-unread-count",
            text: (Notification.unread_count(notification.user.id).to_i + 1)
          )
          cable_ready.broadcast
        end
      end
end
