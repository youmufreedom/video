require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:organisation) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:organisation_id) }
  end

  describe 'devise modules' do
    let(:organisation) { create(:organisation)}
    subject { User.new(organisation: organisation) }

    # Example test for Devise's :validatable module
    it 'is valid with a valid email and password' do
      subject.email = 'test@example.com'
      subject.password = 'password123'
      expect(subject).to be_valid
    end

  end

  describe 'roles' do
    it 'includes roles staff and admin' do
      is_expected.to define_enum_for(:role).with_values(staff: 0, admin: 1)
    end

    it 'defaults to staff role' do
      user = build(:user, ) # Using FactoryBot without specifying a role
      expect(user.role).to eq('staff')
    end
  end
end
