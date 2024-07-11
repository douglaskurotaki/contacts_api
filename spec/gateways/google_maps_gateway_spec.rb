# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleMapsGateway do
  describe '.by_zipcode' do
    let(:zipcode) { '01001000' }
    let(:json_response) { File.read(Rails.root.join('spec', 'fixtures', 'google_maps_response.json')) }
    let(:base_url) { described_class::GOOGLE_MAPS_HOST }
    let(:result_type) { described_class::RESULT_TYPE }
    let(:api_key) { described_class::GOOGLE_MAPS_KEY }
    let(:url) do
      "#{base_url}/#{result_type}?address=#{zipcode}&key=#{api_key}"
    end
    let(:fake_response) { instance_double(Faraday::Response, body: json_response) }

    before do
      allow(HttpAdapter).to receive(:get).and_return(fake_response)
    end

    it 'calls the HttpAdapter with the correct URL' do
      GoogleMapsGateway.by_zipcode(zipcode:)
      expect(HttpAdapter).to have_received(:get).with(url)
    end

    it 'returns the body of the response' do
      result = GoogleMapsGateway.by_zipcode(zipcode:)
      expect(result).to eq(json_response)
    end
  end
end
