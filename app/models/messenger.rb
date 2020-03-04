require 'nexmo'

class Messenger < ApplicationRecord
  def self.send_update_message(recipients)
    client = Nexmo::Client.new

    recipients.each do |recipient|
      if recipient.subscribed == true
        client.sms.send(
          from: ENV['FROM_NUMBER'],
          to: recipient.number,
          text: self.update_message
        )
      end
    end
  end

  def self.update_message
    <<~HEREDOC
    The Israeli Health Ministry website on the Corona Virus has been updated in the past 12 hours.
    Visit https://www.health.gov.il/Subjects/disease/corona/Pages/default.aspx for the latest information.
    To unsubscribe from this list please reply with the number "1".
    HEREDOC
  end
end
