FactoryBot.define do
  factory :service_provider do
    name { "Company Name" }
    # after(:build) do |sp|
    #   sp.logotype.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_logo.png')), filename: "logo-#{sp.name.underscore}.png", content_type: 'image/png')
    #   sp.banner.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_banner.jpg')), filename: "logo-#{sp.name.underscore}_banner.png", content_type: "image/jpg")

    # end
  end
end
