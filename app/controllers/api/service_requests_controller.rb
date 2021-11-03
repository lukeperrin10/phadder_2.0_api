# frozen_string_literal: true

class Api::ServiceRequestsController < ApplicationController
  before_action :authenticate_api_user!
  def index
    service_requests = ServiceRequestFilteringService.by_state_category_location(current_api_user)
    render json: service_requests, each_serializer: ServiceRequests::IndexSerializer
  end

  def show
    service_request = ServiceRequest.find(params[:id])
    render json: service_request, serializer: ServiceRequests::ShowSerializer
  end

  def create
    service_request = ServiceRequest.create(service_request_params
                                              .except(:images)
                                              .merge!(user: current_api_user))
    attach_image(service_request)
    if service_request.persisted?
      render json: { message: "Your request was successfully submitted!" }
    else
      render json: { messsage: service_request.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def service_request_params
    params.permit(:title,
                  :details,
                  :budget,
                  :time_frame,
                  :location,
                  languages: [],
                  images: [],
                  category_ids: [])
  end

  def attach_image(service_request)
    if params['images']&.present?
      params['images'].each do |image|
        CropImageService.attach_image(image, service_request.images)
      end
    end
  end
end
