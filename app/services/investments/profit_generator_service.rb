module Investments
  class ProfitGeneratorService
    PROFIT = 'Profit'.freeze

    def initialize(user_id, calculated_total_amount, period, investment)
      @user = User.find(user_id)
      @investment = investment
      @calculated_total_amount = calculated_total_amount.to_f
      @period = period.to_i
      @profit_per_period = @calculated_total_amount / @period
    end

    def call
      create_profit_transactions
    end

    private

    def create_profit_transactions
      profit_wallet = @user.wallet_by_type(WalletType::PROFIT)

      @period.times do |i|
        profit_wallet.profits.create!(
          amount: @profit_per_period,
          paid_date: Date.today + (i+1).months,
          investment_id: @investment.id,
        )
      end
    end

  end
end
