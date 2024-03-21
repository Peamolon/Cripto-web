class UpdateCryptocurrencyPricesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ::Cryptocurrency::CryptocurrencyService.broadcast_updated_prices
  end
end
