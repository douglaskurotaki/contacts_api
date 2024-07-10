# frozen_string_literal: true

class HttpAdapter
  DEFAULT_HEADERS = {
    'Accept' => 'application/json',
    'Content-Type' => 'application/json'
  }.freeze

  class LogFormatter < Faraday::Logging::Formatter
    def response(env)
      return if env.success?

      error("Status: #{env.status} - Response: #{env.body}")
    end
  end

  class << self
    def get(url, query: nil, headers: DEFAULT_HEADERS)
      conn.get(url, query, headers)
    end

    def conn
      Faraday.new do |faraday|
        faraday.use Faraday::Response::RaiseError
        faraday.request :json
        faraday.response :json
        faraday.response :logger, Rails.logger, formatter: LogFormatter, headers: false
      end
    end
  end
end
