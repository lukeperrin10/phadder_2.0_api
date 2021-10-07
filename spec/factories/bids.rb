FactoryBot.define do
  factory :bid do
    amount { 1.5 }
    service_request { nil }
    creator { nil }
  end
end
