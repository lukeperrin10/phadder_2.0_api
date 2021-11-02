class Api::TrackedServiceRequestsController < ApplicationController
  before_action :authenticate_api_user!

  def index
    tracked_services = current_api_user.service_provider.tracked_service_requests
    render json: tracked_services, each_serializer: TrackedServicesSerializer
  end

  def create
    service_request = ServiceRequest.find(params[:service_request_id]) if params[:service_request_id]
    tracked_service_request = current_api_user.service_provider.tracked_service_requests.create(
      service_request: service_request, creator: current_api_user
    )
    if tracked_service_request.persisted?
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
