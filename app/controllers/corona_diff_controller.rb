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
    puts params
  end

  private

  def recipient_params
    params.permit(:number, :subscribed)
  end
end
