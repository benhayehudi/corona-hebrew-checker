class CoronaDiffController < ApplicationController

  def index
  end

  def create
    @recipient = Recipient.new(recipient_params)
    if @recipient.save
      flash[:notice] = "Phone number saved successfully."
    else
      flash[:alert] = "Form did not save. Please fix and try again."
    end
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

  private

  def recipient_params
    params.permit(:number, :subscribed)
  end
end
