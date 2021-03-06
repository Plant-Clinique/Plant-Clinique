class CreateChatbotMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chatbot_messages do |t|
      t.string :user_id
      t.datetime :time_sent
      t.boolean :from_bot
      t.string :content

      t.timestamps
    end
  end
end
