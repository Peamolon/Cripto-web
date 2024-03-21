require 'rails_helper'

RSpec.describe Cryptocurrency::CryptocurrencyService do
  describe '.fetch_cryptocurrencies_info' do
    before do
      stub_request(:get, /coinapi.io/).to_return(status: 200, body: {
        asset_id_base: 'BTC',
        rate: 50000.0
      }.to_json)

      FactoryBot.create(:crypto, name: 'Bitcoin', symbol: 'BTC')
      FactoryBot.create(:crypto, name: 'Ethereum', symbol: 'ETH')
      FactoryBot.create(:crypto, name: 'Cardano', symbol: 'ADA')
    end

    it 'returns an array of cryptocurrency information' do
      result = described_class.fetch_cryptocurrencies_info

      expect(result.size).to eq(3)
      expect(result.first).to include(
                                id: kind_of(Integer),
                                name: 'Bitcoin',
                                symbol: 'BTC',
                                price: 50000.0,
                                monthly_return_percentage: 5.0
                              )
      expect(result.second).to include(
                                 monthly_return_percentage: 4.2
                               )
      expect(result.third).to include(
                                monthly_return_percentage: 1.0
                              )
    end
  end
end
