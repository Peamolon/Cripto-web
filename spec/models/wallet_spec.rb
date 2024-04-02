require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:wallet_type) }
    it { is_expected.to have_many(:investments) }
    it { is_expected.to have_many(:profits) }
    it { is_expected.to have_many(:releases) }
  end
end
