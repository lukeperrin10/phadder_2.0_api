FactoryBot.define do
  factory :address do
    street { "MyString" }
    post_code { "MyString" }
    city { "MyString" }
    country { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    service_provider { nil }
  end
end
