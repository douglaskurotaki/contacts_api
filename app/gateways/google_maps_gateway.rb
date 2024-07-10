# frozen_string_literal: true

class GoogleMapsGateway
  GOOGLE_MAPS_HOST = ENV.fetch('GOOGLE_MAPS_HOST').freeze
  GOOGLE_MAPS_KEY = ENV.fetch('GOOGLE_MAPS_KEY').freeze
  RESULT_TYPE = 'json'

  def self.by_zipcode(zipcode:, http_adapter: HttpAdapter)
    http_adapter.get(
      "#{GOOGLE_MAPS_HOST}/#{RESULT_TYPE}?address=#{zipcode}&key=#{GOOGLE_MAPS_KEY}"
    ).body
  end
end
