require 'net/http'
require 'uri'
require 'json'

class CoinapiClient
  BASE_URL = Rails.application.credentials.coinapi[:base_url]
  API_KEY = Rails.application.credentials.coinapi[:api_key]

  DEFAULT_CURRENCY_VALUE = 'USD'.freeze
  public_constant :DEFAULT_CURRENCY_VALUE

  def self.fetch_cryptocurrency_data(symbol)
    #uri = URI("#{BASE_URL}/exchangerate/#{symbol}/#{DEFAULT_CURRENCY_VALUE}")
    #request = Net::HTTP::Get.new(uri)
    #request["X-CoinAPI-Key"] = API_KEY

    #response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    #  http.request(request)
    #end

    #JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    mock_responses = {
      "BTC" => {"time" => "2024-03-20T21:47:19.0000000Z", "asset_id_base" => "BTC", "asset_id_quote" => "USD", "rate" => 67692.99559060749},
      "ETH" => {"time" => "2024-03-20T21:47:19.0000000Z", "asset_id_base" => "ETH", "asset_id_quote" => "USD", "rate" => 2300.50}, # Ejemplo
      "ADA" => {"time" => "2024-03-20T21:47:19.0000000Z", "asset_id_base" => "ADA", "asset_id_quote" => "USD", "rate" => 1.25} # Ejemplo
    }

    # Devuelve el mock de la respuesta basado en el símbolo proporcionado
    mock_responses[symbol]
  end
end