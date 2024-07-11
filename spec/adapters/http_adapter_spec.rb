# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpAdapter, type: :adapter do
  describe '.get' do
    let(:url) { 'http://test.com/data' }
    let(:response_body) { { key: 'value' }.to_json }
    let(:status) { 200 }
    let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

    before do
      stub_request(:get, url)
        .with(headers:)
        .to_return(status:, body: response_body, headers: {})
    end

    it 'makes a GET request to the provided URL with default headers' do
      response = described_class.get(url)
      expect(JSON.parse(response.body)).to eq(JSON.parse(response_body))
    end

    context 'when the request fails' do
      let(:status) { 404 }
      let(:response_body) { { error: 'Not found' }.to_json }

      it 'logs the error response' do
        expect(Rails.logger).to receive(:error).with(/Status: 404/)
        expect { described_class.get(url) }.to raise_error(Faraday::ResourceNotFound)
      end
    end
  end
end
