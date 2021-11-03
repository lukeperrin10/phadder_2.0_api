class User < ActiveRecord::Base
  after_initialize :set_default_role, if: :new_record?
  after_create :add_basic_avatar

  enum role: %i[end_user service_provider super_admin]

  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates_length_of :first_name, minimum: 3, maximum: 50, allow_blank: true
  validates_length_of :last_name, minimum: 3, maximum: 50, allow_blank: true

  has_many :service_requests
  has_many :bids, foreign_key: 'creator_id'
  belongs_to :service_provider, optional: true
  has_many :deals, through: :service_requests
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  has_one_attached :avatar

  def full_name
    [first_name, last_name].join(' ') if first_name && last_name
  end

  def display_name
    full_name || email
  end

  private

  def set_default_role
    self.role ||= :end_user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      # user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def add_basic_avatar
    avatar.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_avatar.png')), filename: "avatar-#{email}.png", content_type: 'image/png')
  end
end
