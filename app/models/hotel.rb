class Hotel < ApplicationRecord
  has_many :users, through: :visits
  has_many :visits

  validates :name, uniqueness: true, presence: true
  validates :address, presence: true
  validates :image_url, presence: true
  validates :price, presence: true
  validates :city, presence: true

  def self.query_by_city(city)
    where(city: city)
  end

  def self.query_by_price(max_price)
    where(price: (0)..max_price.to_i)
  end

  def self.get_data(city)
    doc = Nokogiri::HTML(open("https://www.hotels.com/search.do?q-destination=#{city}"))

    doc.css(".hotel-wrap").first(15).each do |hotel|
      hotel_name =  hotel.css(".p-name").css("a").text.strip

      img_url = hotel.css(".u-photo").first.values.last.split(/'/)[1] rescue img_url ="https://via.placeholder.com/250x140"


      hotel_price =  hotel.css(".price").css("ins").text.gsub(/\D/, '')

      if hotel_price.empty?
        hotel_price =  hotel.css(".price").text.gsub(/\D/, '')
      end

      hotel_address =  hotel.css(".contact").text

      Hotel.create(name: hotel_name, image_url: img_url, price: hotel_price, address: hotel_address, city: city)
    end
  end

end
