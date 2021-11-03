class Bid < ApplicationRecord
  belongs_to :service_request
  belongs_to :creator, class_name: 'User'
  belongs_to :service_provider
  has_one :deal

  validates_presence_of :amount, message: 'Bid offer can\'t be blank'
  after_create :update_sr_state

  def state_message
    "Accepted on #{self.deal.created_at.to_formatted_s(:short)} by #{self.deal.creator.display_name}" if self.deal
  end

  private 
  def update_sr_state 
    unless self.service_request.pending?
      self.service_request.fire_state_event(:receive_bid)
    end
  end
end
