require 'json'
require 'net/http'

class SymptomAssessor
  attr_accessor :plant_type, :symptoms

  CHECK_TYPE = { 
                  "more" => lambda {|ideal, estimate| estimate > ideal},
                  "less" => lambda {|ideal, estimate| estimate < ideal}
                }
  
  CHECK_TARGET = {
                  "soil_humidity" => lambda {
                    |plant_data| plant_data['growth']['soil_humidity']
                  },
                  "maximum_temperature" => lambda {
                    |plant_data| plant_data['growth']['maximum_temperature']['deg_f']
                  },
                  "minimum_temperature" => lambda {
                    |plant_data| plant_data['growth']['minimum_temperature']['deg_f']
                  },
                  "minimum_root_depth" => lambda {
                    |plant_data| plant_data['growth']['minimum_root_depth']['cm']
                  },
                  "soil_nutriments" => lambda {
                    |plant_data| plant_data['growth']['soil_nutriments']
                  },
                  "light" => lambda {
                    |plant_data| plant_data['growth']['light']
                  }
                }

  CHECK_QUESTION = {
                  "soil_humidity" => "On a scale of 0 to 10, how moist is your plant's soil usually?",
                  "maximum_temperature" => "What is the warmest temperature, in fahrenheit, reached every day where your plant is?",
                  "minimum_temperature" => "What is the coldest temperature, in fahrenheit, reached every day where your plant is?",
                  "minimum_root_depth" =>  "How many centimeters deep did you bury your plant's seeds?",
                  "soil_nutriments" => "On a scale of 0 to 10, how much fertilizer is in your plant's soil?",
                  "light" => "On a scale of 0 to 10, how much sunlight does your plant get every day?"
                }
  
  FILE_PATH = File.join(Rails.root, 'lib', 'assets', 'symptoms.json')

  def initialize(plant_type)
    @plant_type = plant_type
    file = File.read(FILE_PATH)
    @symptoms = JSON.parse(file)["symptoms"]
  end

  def get_symptom_select_options
    @symptoms.map {|symptom| [symptom['description'], symptom['id']]}
  end

  def get_symptom_causes(symptom_id)
    @symptoms[symptom_id]['causes'].sort_by { |cause| -cause['likelihood'] }
  end

  def get_question_using_id(symptom_id, cause_id)
    cause_info = get_symptom_causes(symptom_id)[cause_id]
    CHECK_QUESTION[cause_info['check']]
  end

  def get_question_using_cause(cause_info)
    CHECK_QUESTION[cause_info['check']]
  end

  def get_questionless_diagnosis(symptom_id, cause_id)
    cause_info = get_symptom_causes(symptom_id)[cause_id]
    diagnosis = cause_info['description']
    return diagnosis
  end

  def get_diagnosis(plant_trefle_id, symptom_id, cause_id, user_plant_estimate)
    cause_info = get_symptom_causes(symptom_id)[cause_id]
    field = cause_info['check']
    diagnosis = cause_info['description']
    check_type = cause_info['check_type']

    plant_data = JSON.parse(Net::HTTP.get(
                                URI.parse(
                                  "https://trefle.io/api/v1/plants/#{plant_trefle_id}?token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw"
                                )
                              )
                            )['data']['main_species']

    api_ideal_for_plant_type = CHECK_TARGET[field].call(plant_data)
    if check_type
      if api_ideal_for_plant_type and CHECK_TYPE[check_type].call(api_ideal_for_plant_type, user_plant_estimate)
        return diagnosis
      end
    end
    return nil
  end

end