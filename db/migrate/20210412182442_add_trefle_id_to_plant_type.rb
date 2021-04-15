class AddTrefleIdToPlantType < ActiveRecord::Migration[6.1]
  def change
    add_column :plant_types, :trefle_id, :int
  end
end
