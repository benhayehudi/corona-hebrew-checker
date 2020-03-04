require 'HTTParty'
require 'Nokogiri'
class Scraper < ApplicationRecord
  def self.call(url)
    self.get_url(url)
  end
  
  def self.get_url(url)
    doc = HTTParty.get(url)
    parsed_page ||= Nokogiri::HTML(doc)
    self.parse_text(parsed_page)
  end

  def self.parse_text(data)
    text = data.css('.ContentLayoutMiddleSide').children.map{|v| v.text}
    if text == []
      puts "There was no text received from the web scrape."
      exit
    else
      puts "There was data in the text received from the web scrape."
      self.store_text(text)
    end
  end

  def self.store_text(text)
    record = DiffStorage.new
    record.website_data = text
    if record.save
      puts "Record Updated Successfully"
    end
  end
end
