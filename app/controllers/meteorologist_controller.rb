require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================
    @urla = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address_without_spaces

    @parsed_dataa = JSON.parse(open(@urla).read)

        @lat = @parsed_dataa["results"][0]["geometry"]["location"]["lat"]

        @lng = @parsed_dataa["results"][0]["geometry"]["location"]["lng"]


        @urlb = "https://api.forecast.io/forecast/91530b5a0a4bd8692071407784982ee0/"+@lat.to_s+","+@lng.to_s

        @parsed_datab = JSON.parse(open(@urlb).read)

            @current_temperature = @parsed_datab["currently"]["temperature"]

            @current_summary = @parsed_datab["currently"]["summary"]

            @summary_of_next_sixty_minutes = @parsed_datab["minutely"]["summary"]

            @summary_of_next_several_hours = @parsed_datab["hourly"]["summary"]

            @summary_of_next_several_days = @parsed_datab["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
