RSpec.describe User, type: :model do
  describe 'Factory' do
    it 'for :user is valid' do
      expect(create(:user)).to be_valid
    end
  end

  describe 'Database' do
    describe 'table' do
      it { is_expected.to have_db_column :email }
      it { is_expected.to have_db_column :first_name }
      it { is_expected.to have_db_column :last_name }
      it { is_expected.to have_db_column :encrypted_password }
      # it { is_expected.to have_db_column :language_code }
    end

    describe 'associations' do
      it { is_expected.to have_many :service_requests }
      it { is_expected.to have_many :bids }
      it { is_expected.to have_many :deals }
      it { is_expected.to have_many :received_messages }
      it { is_expected.to belong_to(:service_provider).optional }
    end

      describe "Instance methods" do
        let(:user_without_name) { create(:user, email: "no_name@random.com", first_name: nil, last_name: nil) }
      let(:user_with_name) { create(:user, first_name: "John", last_name: "Doe") }

        it { is_expected.to respond_to :full_name }
        it { is_expected.to respond_to :display_name }
        it { is_expected.to respond_to :avatar }

        describe "#full_name" do
          it "user with name attributes set returns full name" do
            expect(user_with_name.full_name).to eq "John Doe"
          end

          it "user without name attributes set returns false" do
            expect(user_without_name.full_name).to be_falsy
          end
        end

        describe "#display_name" do
          it "user with name attributes set returns full name" do
            expect(user_with_name.display_name).to eq "John Doe"
          end

          it "user without name attributes set returns false" do
            expect(user_without_name.display_name).to eq "no_name@random.com"
          end
        end

        describe "Avatar" do
          it "is valid  " do
            subject.avatar.attach(io: File.open(fixture_path + "/dummy_avatar.png"), filename: "avatar.png", content_type: "image/png")
            expect(subject.avatar).to be_attached
          end
        end
      end

    describe 'Roles' do
      describe 'are defined for' do
        let(:end_user) { create(:user) }
        let(:service_provider) { create(:user, role: :service_provider) }
        let(:super_admin) { create(:user, role: :super_admin) }

        describe '#end_user' do
          it { is_expected.to respond_to :end_user? }
          it { is_expected.to respond_to :end_user! }

          it 'responds true to ".end_user?" when role == :end_user' do
            expect(end_user.end_user?).to eq true
          end

          it 'responds false to ".end_user?" when role != :end_user' do
            expect(super_admin.end_user?).to eq false
          end

          it 'changes role with the bang method' do
            end_user.super_admin!
            expect(end_user.end_user?).to eq false
          end
        end

        describe '#service_provider' do
          it { is_expected.to respond_to :service_provider? }
          it { is_expected.to respond_to :service_provider! }

          it 'responds true to ".service_provider?" when role == :service_provider' do
            expect(service_provider.service_provider?).to eq true
          end
          it 'responds false to ".service_provider?" when role != :service_provider' do
            expect(end_user.super_admin?).to eq false
          end
        end

        describe '#super_admin' do
          it { is_expected.to respond_to :super_admin? }
          it { is_expected.to respond_to :super_admin! }

          it 'responds true to ".super_admin?" when role == :super_admin' do
            expect(super_admin.super_admin?).to eq true
          end

          it 'responds false to ".super_admin?" when role != :super_admin' do
            expect(end_user.super_admin?).to eq false
          end
        end
      end
    end
  end
end
