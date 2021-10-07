class Category < ApplicationRecord
  has_and_belongs_to_many :service_providers
  validates_presence_of :name
end
