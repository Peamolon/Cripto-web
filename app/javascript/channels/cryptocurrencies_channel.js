import consumer from "channels/consumer"

consumer.subscriptions.create("CryptocurrenciesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const priceElement = document.querySelector(`#crypto-price-${data.id}`);
    if (priceElement) {
      priceElement.textContent = `$${parseFloat(data.price).toFixed(2)}`;
    }
  }
});
