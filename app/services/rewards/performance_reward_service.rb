module Rewards
  class PerformanceRewardService
    def initialize(profit)
      @profit = profit
      @investment = profit.investment
      @user = @investment.user
    end

    def distribute
      return unless @profit.paid?

      reward_amount = calculate_reward(@profit.amount)
      distribute_reward_to_downline(reward_amount)
    end

    private

    def calculate_reward(amount)
      amount * 0.0005
    end

    def distribute_reward_to_downline(reward_amount)
      @user.all_ancestors.each do |descendant|
        release_wallet = descendant.wallet_by_type(WalletType::RELEASE)
        next unless release_wallet.present?

        release_wallet.update!(amount: release_wallet.amount + reward_amount)
        create_reward_record(descendant, reward_amount)
      end
    end

    def create_reward_record(user, amount)
      Reward.create!(
        user: user,
        reward_type: Reward::PERFORMANCE,
        amount: amount,
        awarded_at: Time.current,
        referring_user_id: @user.id,
        investment_id: @profit.investment.id
      )
    end
  end
end

