class Deal < ApplicationRecord
  belongs_to :bid
  belongs_to :service_request
  belongs_to :creator, class_name: "User"
end
