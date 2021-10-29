class Bid < ApplicationRecord
  belongs_to :service_request
  # belongs_to :creator
  belongs_to :service_provider
end
