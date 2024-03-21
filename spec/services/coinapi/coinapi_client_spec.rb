require 'rails_helper'

RSpec.describe Coinapi::CoinapiClient do
  describe '.fetch_cryptocurrency_data' do
    context 'when the API call is successful' do
      before do
        stub_request(:get, /coinapi.io/).to_return(
          status: 200,
          body: { asset_id_base: 'BTC', rate: 50000.0 }.to_json
        )
      end

      it 'returns the cryptocurrency data' do
        data = described_class.fetch_cryptocurrency_data('BTC')
        expect(data['asset_id_base']).to eq('BTC')
        expect(data['rate']).to eq(50000.0)
      end
    end
  end
end