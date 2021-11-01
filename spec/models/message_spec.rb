RSpec.describe Message, type: :model do
  describe "Factory" do
    it "for :message is valid" do
      expect(create(:message)).to be_valid
    end
  end

  describe "Database" do
    describe "table" do
      it { is_expected.to have_db_column :body }
      it { is_expected.to have_db_column :origin }
      it { is_expected.to have_db_column :receiver_id }
    end

    describe "associations" do
      it { is_expected.to belong_to :receiver }
    end
  end
end