require 'rails_helper'

RSpec.describe Profit, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:wallet) }
    it { is_expected.to belong_to(:investment) }
  end

  describe 'AASM states' do
    let(:profit) { create(:profit) }

    context 'initial state' do
      it 'is in not_paid state' do
        expect(profit.status).to eq("not_paid")
      end
    end

    context 'pay event' do
      it 'transitions from not_paid to paid' do
        profit.pay!
        expect(profit.status).to eq("paid")
      end

      it 'calls update_balance_and_distribute after pay' do
        expect(profit).to receive(:update_balance_and_distribute)
        profit.pay!
      end
    end

    context 'release event' do
      it 'transitions from paid to released' do
        profit.pay!
        profit.release!
        expect(profit.status).to eq("released")
      end

      it 'calls remove_wallet_balance after release' do
        profit.pay!
        expect(profit).to receive(:remove_wallet_balance)
        profit.release!
      end
    end
  end
end
