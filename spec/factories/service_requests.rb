FactoryBot.define do
  factory :service_request do
    title { "Just a string" }
    details { "Just some longer text..." }
    user
    state { 'new' }
    location { '424 32'}
    after(:build) do |sr|
      sr.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy-service-request-upload-1.jpg')), filename: "avatar-upload.jpg", content_type: 'image/jpg')
    end  
  end
end
