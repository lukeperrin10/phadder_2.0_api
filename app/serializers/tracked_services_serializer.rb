class TrackedServicesSerializer < ActiveModel::Serializer
  attributes :id

  # belongs_to :creator, serializer: Users::ForServiceRequestSerializer
  belongs_to :service_request, serializer: ServiceRequests::ShowSerializer
end
