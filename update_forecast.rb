require 'shipping_forecast'
require 'fileutils'

# Fetch the forecast for all locations
all_forecasts = ShippingForecast.all

# Prepare the HTML content
html_content = "<h1>Latest Shipping Forecast</h1>\n<ul>"
all_forecasts.each do |location, forecast|
  html_content += "<li><strong>#{location}</strong>: #{forecast[:wind]}, #{forecast[:seas]}, #{forecast[:weather]}, #{forecast[:visibility]}</li>"
end
html_content += "</ul>"

# Write to an HTML file
File.write('forecast.html', html_content)
