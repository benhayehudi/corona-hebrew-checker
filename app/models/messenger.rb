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
    אתר משרד הבריאות בנושא נגיף קורונה עודכן ביום האחרון
    לקבלת המידע החדש בקר אתר
    https://www.health.gov.il/Subjects/disease/corona/Pages/default.aspx
    להסרה השב עם מספר 1
    HEREDOC
  end
  
  def self.send_removal_message(to)
    client.sms.send(
      from: ENV['FROM_NUMBER'],
      to: to,
      text: 'הוסרת מהרשימה'
    )
  end
end
