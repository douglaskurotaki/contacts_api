# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactRepository, type: :repository do
  describe '.call' do
    let(:user) { create(:user) }
    let(:contacts) do
      [
        create(:contact, :with_address, user:, name: 'Alice', cpf: '43370106027'),
        create(:contact, :with_address, user:, name: 'Bob', cpf: '48375501000'),
        create(:contact, :with_address, user:, name: 'Charlie', cpf: '03512742009')
      ]
    end

    before do
      allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 })

      contacts
    end

    context 'when filtering by name' do
      it 'returns the correct contacts' do
        result = described_class.call(user:, filter_value: 'Alice')
        expect(result).to contain_exactly(contacts.first)
      end
    end

    context 'when filtering by CPF' do
      it 'returns the correct contacts' do
        result = described_class.call(user:, filter_value: '48375501000')
        expect(result).to contain_exactly(contacts.second)
      end
    end

    context 'with pagination' do
      it 'paginates the results correctly' do
        result = described_class.call(user:, filter_value: nil, order: 'name', page: 2, per_page: 2)
        expect(result).to contain_exactly(contacts.last)
      end
    end

    context 'with ordering' do
      it 'orders the results by name ascending' do
        result = described_class.call(user:, filter_value: nil, order: 'name', page: 1, per_page: 3)
        expect(result.to_a).to eq([contacts.first, contacts.second, contacts.third])
      end
    end

    context 'when an error occurs' do
      before do
        allow(Contact).to receive(:includes).and_raise(StandardError.new('Unexpected error'))
      end

      it 'logs the error and re-raises it' do
        expect(Rails.logger).to receive(:error).with(/Unexpected error/)
        expect { described_class.call(user:) }.to raise_error(StandardError, 'Unexpected error')
      end
    end
  end
end
