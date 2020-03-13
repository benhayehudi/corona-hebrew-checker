class CoronaDiff < ApplicationRecord

  def self.url
    'https://govextra.gov.il/ministry-of-health/corona/corona-virus-en/'
  end

  def self.check_last_record
    if DiffStorage.any?
      last_snapshot = DiffStorage.last
      new_snapshot = Scraper.call(self.url)
      if (last_snapshot.website_data != new_snapshot.website_data && Recipient.any?)
        puts "There is a difference in the Health Ministry Website and there are subscribers"
        category = new_snapshot.website_data.split(%r{,\s*})[0].upcase
        Messenger.send_update_message(Recipient.all, category)
      else
        puts "There is no difference in the Health Ministry Website and/or there are no subscribers"
      end
    else
      puts "Creating first scraped snapshot"
      Scraper.call(self.url)
    end
  end
end
