class CreateUserPlants < ActiveRecord::Migration[6.1]
  def change
    create_table :user_plants do |t|
      t.integer :user_id
      t.string :name
      t.float :age
      t.string :plant_type
      t.string :img_url
      t.string :description

      t.timestamps
    end
  end
end
