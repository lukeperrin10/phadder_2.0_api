class ServiceProvider < ApplicationRecord
  has_many :addresses
  has_and_belongs_to_many :categories
end
