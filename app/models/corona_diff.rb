class CoronaDiff < ApplicationRecord

  def self.url
    'https://govextra.gov.il/ministry-of-health/corona/corona-virus/'
  end

  def self.check_last_record
    if DiffStorage.any?
      last_snapshot = DiffStorage.last
      new_snapshot = Scraper.call(self.url)
      if (last_snapshot != new_snapshot && Recipient.any?)
        puts "There is a difference in the Health Ministry Website and there are subscribers"
        Messenger.send_update_message(Recipient.all)
      else
        puts "There is no difference in the Health Ministry Website and/or there are no subscribers"
      end
    else
      puts "Creating first scraped snapshot"
      Scraper.call(self.url)
    end
  end
end
