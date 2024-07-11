# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/contacts', type: :request do
  let(:user) { create :user }
  let(:credentials) { user.create_new_auth_token }

  let('Accept') { 'application/vnd.contacts.v1' }
  let('client') { credentials['client'] }
  let('access-token') { credentials['access-token'] }
  let('uid') { credentials['uid'] }

  path '/api/contacts' do
    get 'Retrieves all contacts user' do
      tags 'Contacts'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, required: false,
                description: 'Quantidade de registros por página'
      parameter name: :order, in: :query, type: :string, required: false, description: 'Campo de ordenação'
      parameter name: :filter_value, in: :query, type: :string, required: false, description: 'Valor para filtro'
      parameter name: 'access-token', in: :header, type: :string, required: true, description: 'Access Token'
      parameter name: 'client', in: :header, type: :string, required: true, description: 'Client ID'
      parameter name: 'uid', in: :header, type: :string, required: true, description: 'UID'
      parameter name: 'Accept', in: :header, type: :string, required: false, description: 'Accept'

      let(:page) { 1 }
      let(:per_page) { 10 }
      let(:order) { 'name' }
      let(:filter_value) { nil }

      response '200', 'contacts found' do
        schema type: :object,
               properties: {
                 contacts: {
                   type: :array,
                   items: {
                     '$ref' => '#/components/schemas/contact'
                   }
                 },
                 pagination: {
                   type: :object,
                   properties: {
                     current_page: { type: :integer },
                     next_page: { type: :integer, 'x-nullable': true },
                     prev_page: { type: :integer, 'x-nullable': true },
                     total_pages: { type: :integer },
                     total_count: { type: :integer }
                   }
                 }
               }

        let(:user) { create :user }
        let(:Authorization) { "Bearer #{user.create_new_auth_token['access-token']}" }

        before do
          allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 })

          create_list(:contact, 10, :with_address, user:)
        end

        run_test!
      end
    end

    post 'Creates a contact' do
      tags 'Contacts'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true, description: 'Access Token'
      parameter name: 'client', in: :header, type: :string, required: true, description: 'Client ID'
      parameter name: 'uid', in: :header, type: :string, required: true, description: 'UID'
      parameter name: 'contact', in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          cpf: { type: :string },
          phone: { type: :string },
          address_attributes: {
            type: :object,
            properties: {
              street: { type: :string },
              city: { type: :string },
              uf: { type: :string },
              zipcode: { type: :string },
              number: { type: :string },
              complement: { type: :string, 'x-nullable': true },
              neighborhood: { type: :string }
            },
            required: %w[street city uf zipcode number neighborhood]
          }
        },
        required: %w[name cpf phone address_attributes]
      }

      before { allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 }) }

      response '201', 'contact created' do
        schema '$ref' => '#/components/schemas/contact'

        let(:contact) do
          {
            name: 'John Doe',
            cpf: '99262192096',
            phone: '1234567890',
            address_attributes: {
              street: 'Main St',
              city: 'City',
              uf: 'SP',
              zipcode: '12403080',
              number: '123',
              neighborhood: 'Downtown'
            }
          }
        end

        schema '$ref' => '#/components/schemas/contact'

        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:contact) { { name: nil } }
        run_test!
      end
    end
  end

  path '/api/contacts/{id}' do
    let(:existing_contact) { create(:contact, :with_address, user:) }

    get 'Retrieves a specific contact' do
      tags 'Contacts'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true, description: 'ID of the contact'
      parameter name: 'access-token', in: :header, type: :string, required: true, description: 'Access Token'
      parameter name: 'client', in: :header, type: :string, required: true, description: 'Client ID'
      parameter name: 'uid', in: :header, type: :string, required: true, description: 'UID'
      parameter name: 'Accept', in: :header, type: :string, required: false, description: 'Accept'

      let(:id) { existing_contact.id }

      before { allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 }) }

      response '200', 'contact found' do
        schema '$ref' => '#/components/schemas/contact'

        run_test!
      end

      response '404', 'contact not found' do
        let(:id) { 'invalid_id' }

        run_test!
      end
    end

    patch 'Updates a specific contact' do
      tags 'Contacts'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true, description: 'ID of the contact'
      parameter name: 'access-token', in: :header, type: :string, required: true, description: 'Access Token'
      parameter name: 'client', in: :header, type: :string, required: true, description: 'Client ID'
      parameter name: 'uid', in: :header, type: :string, required: true, description: 'UID'
      parameter name: 'contact', in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          cpf: { type: :string },
          phone: { type: :string },
          address_attributes: {
            type: :object,
            properties: {
              id: { type: :integer },
              street: { type: :string },
              city: { type: :string },
              uf: { type: :string },
              zipcode: { type: :string },
              number: { type: :string },
              complement: { type: :string, 'x-nullable': true },
              neighborhood: { type: :string }
            }
          }
        }
      }

      let(:id) { existing_contact.id }
      let(:contact) do
        {
          name: 'Updated Name',
          cpf: existing_contact.cpf,
          phone: existing_contact.phone,
          address_attributes: {
            id: existing_contact.address.id,
            street: 'Updated Street',
            city: existing_contact.address.city,
            uf: existing_contact.address.uf,
            zipcode: existing_contact.address.zipcode,
            number: existing_contact.address.number,
            complement: existing_contact.address.complement,
            neighborhood: existing_contact.address.neighborhood
          }
        }
      end

      before { allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 }) }

      response '200', 'contact updated' do
        schema '$ref' => '#/components/schemas/contact'
        run_test!
      end

      response '404', 'contact not found' do
        let(:id) { 'invalid_id' }
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:contact) { { name: nil } }
        run_test!
      end
    end

    delete 'Deletes a contact' do
      tags 'Contacts'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true, description: 'ID of the contact'
      parameter name: 'access-token', in: :header, type: :string, required: true, description: 'Access Token'
      parameter name: 'client', in: :header, type: :string, required: true, description: 'Client ID'
      parameter name: 'uid', in: :header, type: :string, required: true, description: 'UID'

      let(:id) { existing_contact.id }

      before { allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 }) }

      response '204', 'contact deleted' do
        run_test! do
          expect(Contact.exists?(existing_contact.id)).to be(false)
        end
      end

      response '404', 'contact not found' do
        let(:id) { 'invalid_id' }
        run_test! do
          expect(Contact.exists?(existing_contact.id)).to be(true)
        end
      end
    end
  end
end
