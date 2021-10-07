FactoryBot.define do
  factory :tracked_service_request do
    service_provider 
    service_request 
    creator factory: :user
  end
end
