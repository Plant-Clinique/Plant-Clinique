require "test_helper"

class PlantTypeTest < ActiveSupport::TestCase
  def setup
    @plant_type= PlantType.new(name: "Rice")
  end
  test "should be valid" do
    assert @plant_type.valid?
  end
end
