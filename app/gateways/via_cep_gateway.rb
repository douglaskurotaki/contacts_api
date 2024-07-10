# frozen_string_literal: true

class ViaCepGateway
  VIA_CEP_HOST = ENV.fetch('VIA_CEP_HOST').freeze
  RESULT_TYPE = 'json'

  def self.by_zipcode(zipcode:, http_adapter: HttpAdapter)
    http_adapter.get("#{VIA_CEP_HOST}/#{zipcode}/#{RESULT_TYPE}").body
  end
end
