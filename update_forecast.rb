require 'shipping_forecast'

# Fetch the forecast for all locations
all_forecasts = ShippingForecast.all

# Start building the HTML content for the Shipping Forecast section
html_content = "<div id='shipping-forecast'>\n<h2>Latest Shipping Forecast</h2>\n<ul>\n"
all_forecasts.each do |location, forecast|
  html_content += "<li><strong>#{location}</strong>: #{forecast[:wind]}, #{forecast[:seas]}, #{forecast[:weather]}, #{forecast[:visibility]}</li>\n"
end
html_content += "</ul>\n</div>"

# Write to an HTML file that will be included in the index.html
File.write('forecast_fragment.html', html_content)
