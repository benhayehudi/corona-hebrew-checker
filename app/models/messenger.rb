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
    There has been an update to the Ministry of Health Corona Virus Website
    To see the latest information visit:
    https://www.health.gov.il/Subjects/disease/corona/Pages/default.aspx
    To be removed from the list please respond with "1".
    HEREDOC
  end
  
  def self.send_removal_message(to)
    client.sms.send(
      from: ENV['FROM_NUMBER'],
      to: to,
      text: 'You have been removed.'
    )
  end
end
