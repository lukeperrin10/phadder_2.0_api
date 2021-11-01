class TrackedServiceRequest < ApplicationRecord
  belongs_to :service_provider
  belongs_to :service_request
  belongs_to :creator, class_name: "User"
end
