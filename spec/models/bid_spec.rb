RSpec.describe Bid, type: :model do
  describe 'Database' do
    describe 'table' do
      it { is_expected.to have_db_column :amount }
      # it {is_expected.to have_db_column :note}
    end

    describe 'associations' do
      it { is_expected.to belong_to :service_request }
      # it { is_expected.to belong_to :creator }
      it { is_expected.to belong_to :service_provider }
      #       it { is_expected.to have_one :deal }
    end

    #     describe 'validations' do
    #       it { is_expected.to validate_presence_of(:amount).with_message "Bid offer can't be blank"}
    #     end
  end
end
