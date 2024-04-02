require 'rails_helper'

RSpec.describe WalletType, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:wallet_type, :investment) }

    it { is_expected.to validate_presence_of(:name_type) }
    it { is_expected.to validate_uniqueness_of(:name_type) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:wallets) }
  end

  describe 'constants' do
    it 'defines a list of wallet types' do
      expect(WalletType::WALLET_TYPES).to contain_exactly('Investment', 'Profit', 'Release')
    end
  end
end
