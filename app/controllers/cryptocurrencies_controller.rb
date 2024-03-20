class CryptocurrenciesController < ApplicationController
  before_action :authenticate_user!
  def index
    @bitcoin_data = CoinapiClient.fetch_cryptocurrency_data('BTC')
    @ether_data = CoinapiClient.fetch_cryptocurrency_data('ETH')
    @cardano_data = CoinapiClient.fetch_cryptocurrency_data('ADA')
  end
end
