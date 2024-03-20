class CryptocurrencyService
  def self.fetch_cryptocurrencies_info
    cryptocurrencies = Crypto.all
    cryptocurrencies.map do |crypto|
      data = CoinapiClient.fetch_cryptocurrency_data(crypto.symbol)
      {
        id: crypto.id,
        name: crypto.name,
        symbol: data["asset_id_base"],
        price: data["rate"],
      }
    end
  end
end