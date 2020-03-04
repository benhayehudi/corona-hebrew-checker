require 'HTTParty'
require 'httparty_with_cookies'
require 'nokogiri'

class Scraper < ApplicationRecord
  include HTTParty_with_cookies

  def self.call(url)
    self.get_url(url)
  end
  
  def self.get_url(url)
    doc = HTTParty.get(url, :verify => false)
    puts doc
    parsed_page ||= Nokogiri::HTML(doc)
    puts parsed_page

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
