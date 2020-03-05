require 'nexmo'

class Messenger < ApplicationRecord
  def self.send_update_message(recipients)
    client = Nexmo::Client.new(
      api_key: ENV['NEXMO_API_KEY'],
      api_secret: ENV['NEXMO_API_SECRET']
    )
    puts "Sending Message to Each Recipient"
    recipients.each do |recipient|
      if recipient.subscribed == true
        client.sms.send(
          from: ENV['FROM_NUMBER'],
          to: recipient.number,
          text: self.update_message
        )
        puts "Sent message to #{recipient.number}"
      end
    end
  end

  def self.update_message
    <<~HEREDOC
    There has been an update to the Israeli Ministry of Health Corona Virus Website.
    To see the latest information visit: https://govextra.gov.il/ministry-of-health/corona/corona-virus/
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

  def self.validate_number(phone)
    phone = phone.gsub(/([-() ])/, '') # remove dashes and parenthesis
    phone_split = phone.split('')
    if phone_split[3] == '0'
      phone_split.delete_at(3)
    end
    phone = phone_split.join('')

    return phone
  end
end
