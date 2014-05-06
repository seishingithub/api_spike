require 'faraday'
require 'json'
require 'pp'
require 'date'
require 'pry'

response = Faraday.get 'http://api.openweathermap.org/data/2.5/weather?q=Boulder,%20co'
response2 = Faraday.get 'http://api.openweathermap.org/data/2.5/forecast/daily?q=Boulder,%20co&units=imperial'

JSON.parse(response.body)
JSON.parse(response2.body)
response
response2

@coord = JSON.parse(response.body) # display current weather for Boulder, CO
current_weather = @coord["weather"].first["description"]

@coord2 = JSON.parse(response2.body) # get 7-day forecast for Boulder, CO

def daily_forecast(info)
  info["weather"][0]["description"]
end

def daily_expected_temp(info)
  info["temp"]["day"].to_i
end

def daily_minimum_temp(info)
  info["temp"]["min"].to_i
end

def daily_maximum_temp(info)
  info["temp"]["max"].to_i
end

def day_of_week(info)
  unix_time = info["dt"] #unix_time is assigned the value of info at 'dt'
  date = DateTime.strptime(unix_time.to_s, '%s') #date is assigned the date(DateTime) parsed from unix_time
  date.strftime('%A') #.?? => 'Monday' (what is date?)
end

puts "The current weather for Boulder, CO is #{current_weather}."

puts "The 7-day forecast is as follows:"

@coord2['list'].map do |info|
  puts "#{day_of_week(info)}, we expect #{daily_forecast(info)} with #{daily_expected_temp(info)} degrees with a minimum of #{daily_minimum_temp(info)} and a maximum of #{daily_maximum_temp(info)}."
end
