# frozen_string_literal: true
class Api::BidsController < ApplicationController
  before_action :authenticate_api_user!

  def create
    bid = Bid.create(bid_params.merge!(creator: current_api_user, service_provider: current_api_user.service_provider))
    if bid.persisted?
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:service_request_id, :amount, :note)
  end
end