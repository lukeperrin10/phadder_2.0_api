require 'rails_helper'

RSpec.describe ServiceProvider, type: :model do
  describe 'Factory' do
    it 'for :service_provider is valid' do
      expect(create(:service_provider)).to be_valid
    end

    # it "for :service_provider as #freelancer is valid" do
    #   expect(create(:service_provider, variant: :freelancer)).to be_valid
    # end
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many :categories }
    it { is_expected.to have_many :addresses }
    # it { is_expected.to have_many :users }
    # it { is_expected.to have_many :tracked_service_requests }
  end

  # describe "Scopes" do
  #   describe "#by_category" do
  #     let!(:category) { create(:category) }
  #     subject do
  #       resource = create(:service_provider)
  #       resource.categories << category
  #       resource.save
  #       resource
  #     end

  #     it "retuns resource using scope" do
  #       query = ServiceProvider.by_category(category.id)
  #       expect(query).to include subject
  #     end
  #   end
  # end

  # describe "Instance methods" do

  #   describe 'variants' do
  #     it { is_expected.to respond_to :company! }
  #     it { is_expected.to respond_to :freelancer! }
  #     it { is_expected.to respond_to :company? }
  #     it { is_expected.to respond_to :freelancer? }

  #     describe "variant scope" do
  #       it { expect(described_class).to respond_to :company }
  #       it { expect(described_class).to respond_to :freelancer }
  #     end
  #   end

  #   describe "Logotype" do
  #     subject {create(:service_provider)}
  #     it "is valid  " do
  #       subject.logotype.attach(io: File.open(fixture_path + "/dummy_logo.png"), filename: "logo-#{subject.name.underscore}_logotype.png", content_type: "image/png")
  #       expect(subject.logotype).to be_attached
  #     end
  #   end

  #   describe "Banner" do
  #     subject {create(:service_provider)}
  #     it "is valid  " do
  #       subject.banner.attach(io: File.open(fixture_path + "/dummy_banner.jpg"), filename: "logo-#{subject.name.underscore}_banner.png", content_type: "image/jpg")
  #       expect(subject.banner).to be_attached
  #     end
  #   end

  #   describe "Categories" do
  #     let(:category_1) {create(:category, name: 'Construction')}
  #     let(:category_2) {create(:category, name: 'House Keeping')}
  #     subject {create(:service_provider, categories: [category_1, category_2])}

  #     it "are defined" do
  #       expect(subject.categories.map{|c| c.name}).to eq  ["Construction", "House Keeping"]
  #     end
  #   end

  #   describe 'Badges' do
  #     # library methods
  #     it {is_expected.to respond_to :badges}
  #     it {is_expected.to respond_to :add_badge}
  #     it {is_expected.to respond_to :rm_badge}

  #     # custom methods
  #     it {is_expected.to respond_to :verified?}
  #    end
  # end
end
