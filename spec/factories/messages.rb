FactoryBot.define do
  factory :message do
    body { "MyText" }
    receiver factory: :user
  end
end
