class CoronaDiffController < ApplicationController

  def index
  end

  def create
    if params[:number].start_with?('972')
      @recipient = Recipient.new(
        subscribed: params[:subscribed], 
        number: Messenger.validate_number(params[:number])
      )
      if @recipient.save
        flash[:notice] = "Phone number saved successfully."
      else
        flash[:alert] = "Form did not save. Please fix and try again."
      end
    else 
      flash[:alert] = "Number must be an Israeli phone number, beginning with country code of 972."
    end
    redirect_to '/'
  end
  
  def event
    if params[:text] == '1'
      recipient = Recipient.find_by(number: params[:msisdn])
      if recipient
        if recipient.update(subscribed: false)
          Messenger.send_removal_message(params[:msisdn])
        end
      end
    end
    puts params

    head :no_content
  end
end
