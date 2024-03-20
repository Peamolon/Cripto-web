class CryptocurrenciesController < ApplicationController
  before_action :authenticate_user!
  def index
    @cryptocurrencies = CryptocurrencyService.fetch_cryptocurrencies_info
  end
end
