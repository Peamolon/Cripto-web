require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:investment) }
    it { is_expected.to belong_to(:referring_user).class_name('User').optional }
  end

  describe 'reward types' do
    it 'includes the expected reward types' do
      expect(Reward::REWARD_TYPES).to contain_exactly('Investment', 'Performance')
    end
  end
end
