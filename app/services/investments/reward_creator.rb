module Investments
  class RewardCreator
    include ActiveModel::Model

    attr_accessor :investment_id, :referring_user_id

    validates :investment_id, presence: true
    validates :referring_user_id, presence: true

    def initialize(attributes={})
      super
    end

    def call
      return false unless valid?

      investment = Investment.find(investment_id)
      return false unless investment

      parent_user = User.find_by(id: referring_user_id)
      return false unless parent_user

      wallet = parent_user.wallet_by_type(WalletType::RELEASE)

      create_reward(investment, parent_user, wallet)

      true
    rescue => e
      errors.add(:base, e.message)
      false
    end

    private

    def create_reward(investment, parent_user, wallet)
      reward_amount = investment.amount * 0.01
      updated_amount =  (wallet.amount + reward_amount).to_f
      wallet.update(amount: updated_amount)

      Reward.create!(
        user_id: parent_user.id,
        reward_type: Reward::INVESTMENT,
        amount: reward_amount,
        awarded_at: DateTime.now,
        investment_id: investment.id,
        referring_user_id: investment.user_id
      )
    end
  end
end
