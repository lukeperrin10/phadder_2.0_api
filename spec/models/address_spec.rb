RSpec.describe Address, type: :model do
  it { is_expected.to belong_to :service_provider }
end
