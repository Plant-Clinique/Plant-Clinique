require 'json'

class SymptomAssessor
  attr_accessor :plant_type, :symptoms

  def initialize(plant_type)
    @plant_type = plant_type
    @symptoms = JSON.parse("symptoms.json")["symptoms"]
    # @symptoms = JSON.parse(Net::HTTP.get(URI.parse('https://trefle.io/api/v1/plants?filter_not%5Bedible_part%5D=null&token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw')))
    plant_types = result['data'].map{ |plant| plant['common_name'] }.reject{ |plant| plant == nil }
  end

  def all_symptoms
    @symptoms[]
  end


end