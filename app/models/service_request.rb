class ServiceRequest < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :bids
  has_one :deal
  has_many_attached :images
  geocoded_by :get_location
  after_create :geocode

  enum budget: %i[small medium large]
  enum time_frame: %i[urgent moderate long_term]

  state_machine :state, initial: :new do
    event :receive_bid do
      transition new: :pending
    end

    event :abandon do
      transition %i[new pending] => :abandoned
    end

    event :accept_bid do
      transition %i[new pending] => :in_progress
    end

    event :finalize do
      transition [:in_progress] => :finalized
    end
  end

  def get_location
    result = PostCodeService.get_location(location)
    self.latitude = result[:latitude]
    self.longitude = result[:longitude]
    self.address = result[:"place name"]
    save
    [latitude, longitude]
  end
end
