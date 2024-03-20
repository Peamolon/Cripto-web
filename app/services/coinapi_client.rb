require 'net/http'
require 'uri'
require 'json'

class CoinapiClient
  BASE_URL = Rails.application.credentials.coinapi[:base_url]
  API_KEY = Rails.application.credentials.coinapi[:api_key]

  DEFAULT_CURRENCY_VALUE = 'USD'.freeze
  public_constant :DEFAULT_CURRENCY_VALUE

  def self.fetch_cryptocurrency_data(symbol)
    uri = URI("#{BASE_URL}/exchangerate/#{symbol}/#{DEFAULT_CURRENCY_VALUE}")
    request = Net::HTTP::Get.new(uri)
    request["X-CoinAPI-Key"] = API_KEY

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end
end