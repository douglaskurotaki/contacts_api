# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/addresses', type: :request do
  path '/api/addresses/{id}' do
    get 'Retrieves an address based on the given zipcode' do
      tags 'Addresses'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string, description: 'zipcode'

      parameter name: 'access-token', in: :header, type: :string, required: true, description: 'Access Token'
      parameter name: 'client', in: :header, type: :string, required: true, description: 'Client ID'
      parameter name: 'uid', in: :header, type: :string, required: true, description: 'UID'
      parameter name: 'Accept', in: :header, type: :string, required: false, description: 'Accept'

      let(:id) { '01001000' }
      let(:user) { create :user }
      let(:credentials) { user.create_new_auth_token }

      let('Accept') { 'application/vnd.contacts.v1' }
      let('client') { credentials['client'] }
      let('access-token') { credentials['access-token'] }
      let('uid') { credentials['uid'] }

      let(:address_response) do
        JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'address_response.json')))
      end

      response '200', 'address found' do
        schema type: :object,
               properties: {
                 zipcode: { type: :string },
                 street: { type: :string },
                 complement: { type: :string },
                 neighborhood: { type: :string },
                 uf: { type: :string },
                 city: { type: :string }
               },
               required: %w[zipcode street neighborhood uf city]

        before do
          allow(ViaCepGateway).to receive(:by_zipcode).with(zipcode: id).and_return({
                                                                                      'logradouro' => 'Praça da Sé',
                                                                                      'localidade' => 'São Paulo',
                                                                                      'complemento' => 'Casa',
                                                                                      'uf' => 'SP',
                                                                                      'cep' => '01001001',
                                                                                      'bairro' => 'Sé'
                                                                                    })
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data).to eq(address_response)
          expect(response.status).to eq(200)
        end
      end

      response '422', 'unprocessable entity' do
        before do
          allow(ViaCepGateway).to receive(:by_zipcode).with(zipcode: id).and_return(nil)
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data).to eq({ 'message' => I18n.t('errors.messages.address_via_cep_not_found') })
          expect(response.status).to eq(422)
        end
      end

      response '401', 'unauthorized' do
        let('client') { nil }
        let('access-token') { nil }
        let('uid') { nil }

        run_test! { |response| expect(response.status).to eq(401) }
      end

      response '404', 'not found route' do
        let(:id) { nil }

        run_test!
      end
    end
  end
end
