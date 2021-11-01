class ServiceProvider < ApplicationRecord
  has_many :addresses
  has_many :users
  has_and_belongs_to_many :categories

  has_one_attached :logotype
  has_one_attached :banner

  after_create :add_basic_logotype
  after_create :add_basic_banner

  def add_basic_logotype
    unless logotype.attached?
      logotype.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_logo.png')), filename: "avatar-#{name.underscore}.png", content_type: 'image/png')
    end
  end

  def add_basic_banner
    unless banner.attached?
      banner.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_banner.jpg')), filename: "avatar-#{name.underscore}_banner.jpg", content_type: 'image/jpg')
    end
  end
end
