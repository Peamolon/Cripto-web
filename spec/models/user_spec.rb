require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('User').optional }
    it { is_expected.to have_many(:children).class_name('User').with_foreign_key('parent_id') }
    it { is_expected.to have_many(:investments) }
    it { is_expected.to have_many(:wallets) }
    it { is_expected.to have_many(:profits).through(:investments) }
    it { is_expected.to have_many(:rewards).dependent(:destroy) }
    it { is_expected.to have_many(:referred_rewards).class_name('Reward').with_foreign_key('referring_user_id').dependent(:destroy) }
  end

  describe '#wallet_by_type' do
    it 'returns the wallet for the given type' do
      user = create(:user)
      expect(user.wallet_by_type('Investment').type).to eq(WalletType::INVESTMENT)
    end
  end

  describe 'callbacks' do
    it 'assigns a default role after creation' do
      user = create(:user)
      expect(user.has_role?(:investor)).to be true
    end

    it 'generates a unique user_code before creation' do
      user = create(:user)
      expect(user.user_code).not_to be_nil
    end
  end
end
