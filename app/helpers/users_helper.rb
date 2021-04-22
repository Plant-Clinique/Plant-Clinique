module UsersHelper
  def trefle(plant)
    b = plant.plant_type
    a = PlantType.where(name: "Garden sorrel").first.trefle_id
    return b
  end


  def Humidity(plant)
    token = "2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y"
    type = plant.plant_type
    plants = JSON
            .parse(
              Net::HTTP.get(
                URI.parse(
                    "https://trefle.io/api/v1/plants/"  +  type +"?token=" + token
                    #https://trefle.io/api/v1/plants/165409?token=2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y
                )
              )
            )#['data'].reject{ |plant| plant['common_name'] == nil }
    humidity =  plants["data"]["main_species"]["growth"]["soil_humidity"]
    #Required humidity of the soil, on a scale from 0 (xerophile) to 10 (subaquatic)
    if(humidity.nil?) then
      return "0"
    end
    return "10"
  end


  def Precipitation(plant)
    token = "2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y"
    type = plant.plant_type
    plants = JSON
            .parse(
              Net::HTTP.get(
                URI.parse(
                    "https://trefle.io/api/v1/plants/"  +  type +"?token=" + token

                    #look up plant
                    #https://trefle.io/api/v1/plants/165409?token=2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y
                    
                    #filter plants to take out null values
                    #https://trefle.io/api/v1/plants?token=2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y&filter_not[soil_humidity]=null&page=1
                )
              )
            )#['data'].reject{ |plant| plant['common_name'] == nil }
    precip =  plants["data"]["main_species"]["growth"]["minimum_precipitation"]
    if(precip.nil?) then
      return "Unknown Precip"
    end
    return precip
  end

  def getPages(plant)
    token = "2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y"
    type = plant.plant_type
    plants = JSON
            .parse(
              Net::HTTP.get(
                URI.parse(
                    #"https://trefle.io/api/v1/plants/"  +  type +"?token=" + token
                    #https://trefle.io/api/v1/plants/165409?token=2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y
                    "https://trefle.io/api/v1/plants?token=" + token + "&filter_not[soil_humidity]=null"
                )
              )
            )#['data'].reject{ |plant| plant['common_name'] == nil }
    pages = plants["links"]["last"].split("=")
    return pages[pages.length()-1]
  end

  def commonNames_Page(plant, page)
    token = "2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y"
    type = plant.plant_type
    plants = JSON
            .parse(
              Net::HTTP.get(
                URI.parse(
                    #"https://trefle.io/api/v1/plants/"  +  type +"?token=" + token
                    #https://trefle.io/api/v1/plants/165409?token=2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y
                    "https://trefle.io/api/v1/plants?token=" + token + "&filter_not[soil_humidity]=null&page=" + page
                )
              )
            )#['data'].reject{ |plant| plant['common_name'] == nil }
    plantsOnPage =  plants["data"]
    names = []
    plantsOnPage.each do |currPlant|
      names.append(currPlant["common_name"])
    end
    return names
  end


  def commonNames(plant)
    numOfPages = getPages(plant).to_i
    names = []
    for i in 1..1
      names.concat(commonNames_Page(plant, i.to_s))
    end
    return names
  end











  def filterRain(plant)
    token = "2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y"
    type = plant.plant_type
    plants = JSON
            .parse(
              Net::HTTP.get(
                URI.parse(
                    #"https://trefle.io/api/v1/plants/"  +  type +"?token=" + token
                    #https://trefle.io/api/v1/plants/165409?token=2yGrEg0Qad9zb1rA5PRoYlsj2L1XNu13A6dC71t-c-Y
                    "https://trefle.io/api/v1/plants?token=" + token + "&filter_not[soil_humidity]=null"
                )
              )
            )#['data'].reject{ |plant| plant['common_name'] == nil }
    precip =  plants["data"].length()
    return plants["data"][0]
  end
end
