require 'rails_helper'

RSpec.describe Address, type: :model do
  before { allow(FindGeolocationUseCase).to receive(:call).and_return({ latitude: -23.0, longitude: -46.0 }) }

  describe 'associations' do
    it { is_expected.to belong_to(:contact) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:zipcode) }
    it { is_expected.to validate_presence_of(:uf) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  describe '#set_geolocation' do
    let(:address) { build(:address) }

    context 'when geolocation is found' do
      before do
        address.valid?
      end

      it 'sets the latitude' do
        expect(address.latitude).to eq(-23.0)
      end

      it 'sets the longitude' do
        expect(address.longitude).to eq(-46.0)
      end
    end

    context 'when geolocation is not found' do
      before do
        address.latitude = nil
        address.longitude = nil

        allow(FindGeolocationUseCase).to receive(:call).and_return(nil)
        address.valid?
      end

      it 'does not set the latitude' do
        expect(address.latitude).not_to be_present
      end

      it 'does not set the longitude' do
        expect(address.longitude).not_to be_present
      end
    end
  end
end
