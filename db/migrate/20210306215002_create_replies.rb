class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :body

      t.timestamps
    end
  end
end
