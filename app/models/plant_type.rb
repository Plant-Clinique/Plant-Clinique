class PlantType < ApplicationRecord
  default_scope { order(name: :asc) } 
end
