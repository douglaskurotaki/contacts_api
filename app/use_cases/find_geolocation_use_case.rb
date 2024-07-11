# frozen_string_literal: true

class FindGeolocationUseCase
  def self.call(zipcode:, gateway: GoogleMapsGateway)
    new(zipcode:, gateway:).call
  end

  def initialize(zipcode:, gateway: GoogleMapsGateway)
    @zipcode = zipcode
    @gateway = gateway
  end

  def call
    return nil if address.blank? || geolocation.blank?

    { latitude:, longitude: }
  end

  private

  attr_reader :zipcode, :gateway

  def address
    @address ||= gateway.by_zipcode(zipcode:)
  rescue StandardError => e
    Rails.logger.error("[#{self.class}] Error fetching address from Google Maps API: #{e.message}")
    raise e
  end

  def geolocation
    address.dig('results', 0, 'geometry', 'location')
  end

  def latitude
    geolocation['lat']
  end

  def longitude
    geolocation['lng']
  end
end
