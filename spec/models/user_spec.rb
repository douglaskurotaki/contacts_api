# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:contacts).dependent(:destroy) }
  end

  describe 'Devise modules' do
    it 'includes Devise modules' do
      expect(described_class.devise_modules).to include(
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable,
        :confirmable,
        :trackable
      )
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    context 'validating uniqueness of email' do
      subject { create(:user, email: 'test@example.com', uid: 'test@example.com') }
      let(:new_user) do
        build(:user, email: 'test@example.com', uid: 'test@example.com')
      end

      it { expect(new_user).to be_valid }

      it 'does not allow same email' do
        new_user.save!
        another_user = build(:user, email: 'test@example.com', uid: 'test@example.com')

        expect(another_user).not_to be_valid
        expect(another_user.errors[:email]).to include('já está em uso')
      end
    end
  end
end
