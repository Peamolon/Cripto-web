module Investments
  class InvestmentReleaseService
    def initialize(investment)
      @investment = investment
    end

    def call
      return false unless can_be_released?

      ActiveRecord::Base.transaction do
        create_release
        @investment.release!
      end
      true
    rescue => e
      Rails.logger.error("Failed to release investment: #{e.message}")
      false
    end

    private

    def can_be_released?
      @investment.finished?
    end

    def create_release
      user = @investment.user
      wallet = user.wallet_by_type(WalletType::RELEASE)
      total_profit = @investment.profits.sum(:amount)
      amount_invested = @investment.amount

      wallet.update!(amount: wallet.amount + (total_profit + amount_invested))

      Release.create!(
        profit_amount: total_profit,
        amount: amount_invested,
        wallet_id: wallet.id,
        investment_id: @investment.id,
        user_id: user.id,
        received_at: Time.now
      )
    end
  end
end
