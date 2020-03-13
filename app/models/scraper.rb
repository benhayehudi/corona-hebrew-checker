require 'httparty'
require 'nokogiri'

class Scraper < ApplicationRecord
  def self.call(url)
    self.get_url(url)
  end
  
  def self.get_url(url)
    doc = HTTParty.get(url)
    only_text ||= Nokogiri::HTML(doc).css('.mst-TextHolder').text
    only_text = only_text.gsub(/\r\n?/, "").strip
    self.check_text(only_text)
  end

  def self.check_text(data)
    if data == '' || data == nil
      puts "There was no text received from the web scrape."
      exit
    else
      puts "There was data in the text received from the web scrape."
      self.store_text(data)
    end
  end

  def self.store_text(text)
    record = DiffStorage.new
    record.website_data = text
    if record.save
      puts "Record Updated Successfully"
    end
    @record = record
    return @record
  end
end
