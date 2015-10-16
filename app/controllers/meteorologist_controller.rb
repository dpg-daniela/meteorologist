require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url_1 = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address

    require 'json'
    
    parsed_data_1 = JSON.parse(open(url_1).read)
    latitude = parsed_data_1["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data_1["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude.to_s
    @longitude = longitude.to_s


    url_2 = "https://api.forecast.io/forecast/f75e23fbc60dd60d1695b54d6c7b4314/"+@latitude+","+@longitude

    require 'json'
    parsed_data_2 = JSON.parse(open(url_2).read)


    @current_temperature = parsed_data_2["currently"]["temperature"]

    @current_summary = parsed_data_2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_2["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
