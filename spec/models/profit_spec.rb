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
        expect(profit).to have_state(:not_paid)
      end
    end

    context 'pay event' do
      before do
        allow(profit).to receive(:update_balance_and_distribute).and_return(true)
        profit.pay!
      end

      it 'transitions from not_paid to paid' do
        expect(profit).to transition_from(:not_paid).to(:paid).on_event(:pay)
      end

      it 'calls update_balance_and_distribute after pay' do
        expect(profit).to have_received(:update_balance_and_distribute)
      end
    end

    context 'release event' do
      before do
        profit.aasm.state = :paid # Forzar el estado a :paid para la prueba
        allow(profit).to receive(:remove_wallet_balance).and_return(true)
        profit.release!
      end

      it 'transitions from paid to released' do
        expect(profit).to transition_from(:paid).to(:released).on_event(:release)
      end

      it 'calls remove_wallet_balance after release' do
        expect(profit).to have_received(:remove_wallet_balance)
      end
    end
  end
end
