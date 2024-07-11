# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViaCepGateway do
  describe '.by_zipcode' do
    let(:zipcode) { '01001000' }
    let(:json_response) do
      { 'logradouro': 'Praça da Sé', 'bairro': 'Sé', 'cidade': 'São Paulo', 'estado': 'SP' }.to_json
    end
    let(:url) { "#{described_class::VIA_CEP_HOST}/#{zipcode}/#{described_class::RESULT_TYPE}" }
    let(:fake_response) { instance_double(Faraday::Response, body: json_response) }

    before do
      allow(HttpAdapter).to receive(:get).and_return(fake_response)
    end

    it 'calls the HttpAdapter with the correct URL' do
      ViaCepGateway.by_zipcode(zipcode:)
      expect(HttpAdapter).to have_received(:get).with(url)
    end

    it 'returns the body of the response as JSON' do
      result = ViaCepGateway.by_zipcode(zipcode:)
      expect(result).to eq(json_response)
    end
  end
end
