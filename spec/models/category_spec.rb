RSpec.describe Category, type: :model do
  describe 'Database' do 
    describe 'associations' do 
      it { is_expected.to have_and_belong_to_many :service_providers}
    end

    describe 'validations' do 
      it { is_expected.to validate_presence_of :name}
    end

    # describe 'instance methods' do  
    #   it { is_expected.to respond_to :translations}
    # end

    # describe 'class methods' do  
    #   subject { described_class }
    #   it { is_expected.to respond_to :with_translations}
    # end
  end
end
