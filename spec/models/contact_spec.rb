# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:address) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:cpf) }

    context 'when validates that cpf is case-sensitively unique' do
      let(:user) { create(:user) }
      let(:cpf) { CPF.generate }
      let(:new_contact) { build(:contact, user:, cpf:) }

      before { create(:contact, user:, cpf:) }

      it 'is expected to be invalid' do
        expect(new_contact).not_to be_valid
      end
    end
  end

  describe '#validate_cpf' do
    let(:contact) { build(:contact, cpf:) }

    context 'when cpf is valid' do
      let(:cpf) { CPF.generate }

      before { contact.valid? }

      it 'normalizes and validates the cpf' do
        expect(contact.errors[:cpf]).to be_empty
        expect(contact.cpf).to eq(cpf)
      end
    end

    context 'when cpf is invalid' do
      let(:cpf) { 'invalid_cpf' }

      before { contact.valid? }

      it 'adds an error for invalid cpf' do
        expect(contact.errors[:cpf]).to include(I18n.t('errors.messages.invalid_format', attribute: 'CPF'))
      end
    end
  end

  describe '#validate_phone' do
    let(:contact) { build(:contact, phone:) }

    context 'when phone is valid' do
      let(:phone) { '11992342345' }

      before { contact.valid? }

      it 'normalizes and validates the phone' do
        expect(contact.errors[:phone]).to be_empty
        expect(contact.phone).to eq(phone)
      end
    end

    context 'when phone is invalid' do
      let(:phone) { '12345' }

      before { contact.valid? }

      it 'adds an error for invalid phone' do
        expect(contact.errors[:phone]).to include(I18n.t('errors.messages.invalid_format', attribute: 'Telefone'))
      end
    end
  end
end
