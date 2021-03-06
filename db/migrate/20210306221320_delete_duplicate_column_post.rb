class DeleteDuplicateColumnPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :create_at
  end
end
