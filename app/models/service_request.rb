class ServiceRequest < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :bids

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
end
