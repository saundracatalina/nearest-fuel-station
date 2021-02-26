class SearchController < ApplicationController
  def index
    location = params[:location]

    conn = Faraday.new(url: "https://developer.nrel.gov")
    response = conn.get("/api/alt-fuel-stations/v1/nearest.json") do |request|
      request.params['location'] = location
      request.params['api_key'] = ENV['FUEL_API_KEY']
      request.params['limit'] = 1
      request.params['fuel_type'] = 'ELEC'
    end

    json = JSON.parse(response.body, symbolize_names: true)
    @fuel_station = json[:fuel_stations]
# work in progress to be able to swap in variable fuel_location into params instead of hard codingn it
    # fuel_location = [@fuel_station[0][:street_address], + @fuel_station[0][:city], + @fuel_station[0][:state], + @fuel_station[0][:zip]]

    conn = Faraday.new(url: "https://www.mapquestapi.com")
    response = conn.get("/directions/v2/route") do |request|
      request.params['key'] = ENV['MAP_API_KEY']
      request.params['from'] = location
      request.params['to'] = "1225+17th+St.+Denver+CO+80202"
      request.params['outFormat'] = "json"
    end
    json = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry


    # https://www.mapquestapi.com/directions/v2/route?key=ENV['MAP_API_KEY']&from=location&to=1225+17th+St.+Denver+CO+80202&outFormat=json
    # https://www.mapquestapi.com/directions/v2/route?key=ENV['MAP_API_KEY']&from=1331+17th+St+LL100%2C+Denver%2C+CO+80202&to=1225+17th+St.%2C+Denver%2C+CO+80202&outFormat=json
  end
end
