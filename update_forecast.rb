# scrape_forecast.rb
require 'nokogiri'
require 'open-uri'

url = 'https://www.bbc.com/weather/coast-and-sea/shipping-forecast' # Replace with the actual URL
output_file = 'data/shipping_forecast.txt' # Path to the output file in your repository

begin
  # Open and parse the page with Nokogiri
  doc = Nokogiri::HTML(URI.open(url))

  File.open(output_file, 'w') do |file|
    doc.css('.wr-c-coastandsea-region').each do |region|
      name = region.at_css('.wr-c-coastandsea-region__region-title h3').text.strip
      wind = region.at_css('.wr-c-coastandsea-forecast__item:contains("Wind") .wr-c-coastandsea-forecast__item__text').text.strip
      sea_state = region.at_css('.wr-c-coastandsea-forecast__item:contains("Sea State") .wr-c-coastandsea-forecast__item__text').text.strip
      weather = region.at_css('.wr-c-coastandsea-forecast__item:contains("Weather") .wr-c-coastandsea-forecast__item__text').text.strip
      visibility = region.at_css('.wr-c-coastandsea-forecast__item:contains("Visibility") .wr-c-coastandsea-forecast__item__text').text.strip

      # Write to file
      file.puts "#{name}:"
      file.puts "  Wind: #{wind}"
      file.puts "  Sea State: #{sea_state}"
      file.puts "  Weather: #{weather}"
      file.puts "  Visibility: #{visibility}"
      file.puts ""
    end
  end

  puts "Scraping completed and data written to #{output_file}"

rescue OpenURI::HTTPError => e
  puts "Error opening #{url}: #{e.message}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
