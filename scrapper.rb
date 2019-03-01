require 'pry'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'rest-client'

class Hotel_Scrape
  def self.get_data(city)

    doc = Nokogiri::HTML(open("https://www.hotels.com/search.do?q-destination=#{city}"))

    doc.css(".hotel-wrap")first(10).each do |hotel|
      binding.pry
      hotel_name =  hotel.css(".p-name").css("a").text.strip

      hotel_url = hotel.css(".u-photo").first.values.last.split(/'/)[1]

      hotel_price = hotel.css(".price").css("ins").text.gsub(/\D/, '')

      hotel_address =  hotel.css(".contact").text
    end

    Hotel.create(hotel_name, hotel_url, hotel_price, hotel_address)
  end
end

#Hotel_Scrape.get_data("Seattle")
