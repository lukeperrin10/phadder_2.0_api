# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # sequence(:email) { |n| "user-#{n}@random.com" }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    #language_code { 'en' }

    # after(:build) do |user|
    #   user.avatar.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_avatar.png')), filename: "avatar-#{user.email}.png", content_type: 'image/png')
    # end
  end
end
