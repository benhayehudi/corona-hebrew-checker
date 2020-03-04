class CoronaDiff < ApplicationRecord

  def self.url
    'https://www.health.gov.il/Subjects/disease/corona/Pages/default.aspx'
  end

  def self.check_last_record
    if DiffStorage.any?
      last_snapshot = DiffStorage.last
      new_snapshot = Scraper.call(self.url)
      Messenger.send_update_message(Recipient.all) if (last_snapshot != new_snapshot && Recipient.any?)
    else
      Scraper.call(self.url)
  end
end
