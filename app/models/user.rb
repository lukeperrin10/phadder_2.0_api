class User < ActiveRecord::Base
  after_initialize :set_default_role, if: :new_record?
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :service_requests
  has_many :bids, foreign_key: 'creator_id'
  enum role: %i[end_user service_provider super_admin]

  belongs_to :service_provider, optional: true

  private

  def set_default_role
    self.role ||= :end_user
  end
end
