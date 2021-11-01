class Message < ApplicationRecord
  belongs_to :receiver, class_name: "User"
end
