class User < ActiveRecord::Base
  after_initialize :set_default_role, if: :new_record?
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum role: %i[end_user service_provider super_admin]

  private

  def set_default_role
    self.role ||= :end_user
  end
end
