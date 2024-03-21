require 'net/http'
require 'uri'
require 'json'

module Coinapi
  class CoinapiClient
    BASE_URL = Rails.application.credentials.coinapi[:base_url]
    API_KEY = '144C7895-9689-4461-BC91-3DCC72AD225C'#Rails.application.credentials.coinapi[:api_key]

    DEFAULT_CURRENCY_VALUE = 'USD'.freeze

    def self.fetch_cryptocurrency_data(symbol)
      uri = build_uri(symbol)
      request = build_request(uri)

      response = perform_request(uri, request)
      parse_response(response)
    rescue StandardError => e
      Rails.logger.error "CoinapiClient error: #{e.message}"
    end

    def self.fake_cryptocurrency_data(symbol)
      mock_responses = {
        "BTC" => {"time" => "2024-03-20T21:47:19.0000000Z", "asset_id_base" => "BTC", "asset_id_quote" => "USD", "rate" => 67692.99559060749},
        "ETH" => {"time" => "2024-03-20T21:47:19.0000000Z", "asset_id_base" => "ETH", "asset_id_quote" => "USD", "rate" => 2300.50}, # Ejemplo
        "ADA" => {"time" => "2024-03-20T21:47:19.0000000Z", "asset_id_base" => "ADA", "asset_id_quote" => "USD", "rate" => 1.25} # Ejemplo
      }

      mock_responses[symbol]
    end

    private

    def self.build_uri(symbol)
      URI("#{BASE_URL}/exchangerate/#{symbol}/#{DEFAULT_CURRENCY_VALUE}")
    end

    def self.build_request(uri)
      request = Net::HTTP::Get.new(uri)
      request["X-CoinAPI-Key"] = API_KEY
      request
    end

    def self.perform_request(uri, request)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
    end

    def self.parse_response(response)
      JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    end
  end
end

