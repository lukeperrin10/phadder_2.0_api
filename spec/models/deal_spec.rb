RSpec.describe Deal, type: :model do
  describe "Database" do
    describe "table" do
      it { is_expected.to have_db_column :service_request_id }
      it { is_expected.to have_db_column :bid_id }
      it { is_expected.to have_db_column :creator_id }
    end

    describe "associations" do
      it { is_expected.to belong_to :service_request }
      it { is_expected.to belong_to :creator }
      it { is_expected.to belong_to :bid }
    end
  end
end