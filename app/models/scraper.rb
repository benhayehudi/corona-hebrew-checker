require 'HTTParty'
require 'nokogiri'

class Scraper < ApplicationRecord

  def self.call(url)
    self.get_url(url)
  end
  
  def self.get_url(url)
    doc = HTTParty.get('https://www.health.gov.il/Subjects/disease/corona/Pages/default.aspx')
    parsed_page ||= Nokogiri::HTML(doc)

    self.parse_text(parsed_page)
  end

  def self.parse_text(data)
    text = data.css('.ContentLayoutMiddleSide').children.map{|v| v.text}

    self.store_text(text)
  end

  def self.store_text(text)
    record = DiffStorage.new
    record.website_data = text
    record.save
  end
end
