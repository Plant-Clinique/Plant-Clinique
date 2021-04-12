require 'json'

class SymptomAssessor
  attr_accessor :plant_type, :symptoms

  CHECK_TYPES = { 
                  "more" : lambda {|ideal, estimate| estimate > ideal},
                  "less" : lambda {|ideal, estimate| estimate < ideal}
                }

  def initialize(plant_type)
    @plant_type = plant_type
    @symptoms = JSON.parse("symptoms.json")["symptoms"]
    # @symptoms = JSON.parse(Net::HTTP.get(URI.parse('https://trefle.io/api/v1/plants?filter_not%5Bedible_part%5D=null&token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw')))
    # plant_types = result['data'].map{ |plant| plant['common_name'] }.reject{ |plant| plant == nil }
  end

  def all_symptoms_descriptions
    @symptoms.map(&:description)
  end

  def get_symptom_causes(symptom_id)
    @symptoms[symptom_id]["causes"].sort_by { |cause| -cause["likelihood"] }
  end

  def get_diagnosis(plant_type, symptom_id, cause_id)
    field = @symptoms[symptom_id][cause_id]["check"]
    diagnosis = @symptoms[symptom_id][cause_id]["description"]
    check_type = @symptoms[symptom_id][cause_id]["check_type"]
    api_ideal_for_plant_type = api + field
    result = JSON.parse(Net::HTTP.get(URI.parse("https://trefle.io/api/v1/plants/search?token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw&q=#{plant.plant_type.parameterize.underscore}")))
    "#{plant.name} is a #{plant.plant_type} and its scientific name is #{result["data"][0]["scientific_name"].titleize}"
    if check_type:
      if CHECK_TYPES[check_type](api_ideal_for_plant_type, user_plant_estimate)
        return diagnosis
      end
    end
  end

end