RSpec.describe ServiceRequest, type: :model do
  describe 'Factory' do
    it 'for :service_request is valid' do
      expect(create(:service_request)).to be_valid
    end
  end

  describe 'Database' do
    describe 'table' do
      it { is_expected.to have_db_column :title }
      it { is_expected.to have_db_column :details }
      it { is_expected.to have_db_column :state }
      it { is_expected.to have_db_column :budget }
      it { is_expected.to have_db_column :time_frame }
      it { is_expected.to have_db_column :languages }
      it { is_expected.to have_db_column :location }
      # it { is_expected.to have_db_column :address }
      # it { is_expected.to have_db_column :latitude }
      # it { is_expected.to have_db_column :longitude }
    end

    describe 'associations' do
      it { is_expected.to belong_to :user }
      it { is_expected.to have_and_belong_to_many :categories }
      it { is_expected.to have_many :bids }
      it { is_expected.to have_one :deal }
    end
  end

  describe 'Enums' do
    it { should define_enum_for(:budget).with_values(%i[small medium large]) }
    it { should define_enum_for(:time_frame).with_values(%i[urgent moderate long_term]) }
  end

  describe 'States, Events and Transitions' do
    subject { create(:service_request) }

    # states
    it { is_expected.to have_states :new, :abandoned, :pending, :in_progress, :finalized }
    # events
    it { is_expected.to handle_events :abandon, :receive_bid, when: :new }
    it { is_expected.to handle_events :abandon, :accept_bid, when: :pending }

    # transitions
    it ':receive_bid transitions from :new to :pending' do
      subject.receive_bid
      expect(subject.pending?).to eq true
    end

    %i[new pending].each do |state|
      it ":abandon transitions from #{state} to :abandoned" do
        subject.state = state
        subject.abandon
        expect(subject.abandoned?).to eq true
      end
    end
  end

  # describe "Categories" do
  #   let(:category_1) {create(:category, name: 'Construction')}
  #   let(:category_2) {create(:category, name: 'House Keeping')}
  #   subject {create(:service_request, categories: [category_1, category_2])}

  #   it "are added" do
  #     expect(subject.categories.map{|c| c.name}).to eq  ["Construction", "House Keeping"]
  #   end
  # end
end
