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
  end
end
