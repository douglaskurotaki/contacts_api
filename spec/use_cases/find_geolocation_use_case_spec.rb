# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FindGeolocationUseCase do
  describe '.call' do
    subject(:call) { described_class.call(zipcode:, gateway:) }

    let(:zipcode) { '01001000' }
    let(:gateway) { class_double(GoogleMapsGateway) }
    let(:geolocation_data) do
      {
        'results' => [{
          'geometry' => {
            'location' => {
              'lat' => -23.550520,
              'lng' => -46.633309
            }
          }
        }]
      }
    end
    let(:expected_result) { { latitude: -23.550520, longitude: -46.633309 } }

    before do
      allow(gateway).to receive(:by_zipcode).with(zipcode:).and_return(geolocation_data)
    end

    it 'fetches geolocation data for the given zipcode' do
      expect(call).to eq(expected_result)
    end

    context 'when the gateway raises an error' do
      before do
        allow(gateway).to receive(:by_zipcode).with(zipcode:).and_raise(StandardError.new('API error'))
      end

      it 'logs the error and re-raises it' do
        expect(Rails.logger).to receive(:error).with(/Error fetching address from Google Maps API: API error/)
        expect { call }.to raise_error(StandardError, 'API error')
      end
    end

    context 'when address data is incomplete' do
      let(:incomplete_data) { { 'results' => [{}] } }

      before do
        allow(gateway).to receive(:by_zipcode).with(zipcode:).and_return(incomplete_data)
      end

      it 'returns nil if required data is missing' do
        expect(call).to be_nil
      end
    end
  end
end
