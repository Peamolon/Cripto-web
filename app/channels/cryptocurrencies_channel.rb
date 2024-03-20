class CryptocurrenciesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cryptocurrencies_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
