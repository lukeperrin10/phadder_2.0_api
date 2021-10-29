class Bid < ApplicationRecord
  belongs_to :service_request
  belongs_to :creator, class_name: 'User'
  belongs_to :service_provider
  has_one :deal
end
