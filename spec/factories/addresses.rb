FactoryBot.define do
  factory :address do
    street { 'Bergsgårdsgärdet' }
    post_code { '42432' }
    city { 'Gothenburg' }
    country { 'Sweden' }
    latitude { '9.99' }
    longitude { '9.99' }
    service_provider { nil }
  end
end
