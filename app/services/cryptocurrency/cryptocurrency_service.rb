module Cryptocurrency
  class CryptocurrencyService
    def self.fetch_cryptocurrencies_info
      cryptocurrencies = Crypto.all
      cryptocurrencies.map do |crypto|
        data = ::Coinapi::CoinapiClient.fetch_cryptocurrency_data(crypto.symbol)
        monthly_return_percentage = calculate_monthly_return_for(crypto.symbol)
        {
          id: crypto.id,
          name: crypto.name,
          symbol: data["asset_id_base"],
          price: data["rate"],
          monthly_return_percentage: monthly_return_percentage,
        }
      end
    end

    def self.broadcast_updated_prices
      Crypto.all.each do |crypto|
        data = ::Coinapi::CoinapiClient.fetch_cryptocurrency_data(crypto.symbol)
        ActionCable.server.broadcast(
          "cryptocurrency_channel",
          {
            id: crypto.id,
            price: data["rate"]
          }
        )
      end
    end

    private

    def self.calculate_monthly_return_for(symbol)
      case symbol
      when 'BTC'
        5.0
      when 'ETH'
        4.2
      when 'ADA'
        1.0
      else
        0
      end
    end
  end
end
