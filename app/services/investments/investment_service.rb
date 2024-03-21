module Investments
  class InvestmentService
    def self.call(params)
      amount = params[:amount].to_f
      crypto = Crypto.find(params[:crypto_id])

      annual_gain = calculate_annual_gain(amount, crypto.monthly_return)

      Investment.create(
        amount: amount,
        user: params[:user],
        crypto: crypto,
        annual_gain: annual_gain
      )
    end

    private

    def self.calculate_annual_gain(amount, monthly_return)
      annual_rate = monthly_return * 12
      compounding_periods = 12
      time_in_years = 1

      amount * (1 + annual_rate / compounding_periods) ** (compounding_periods * time_in_years) - amount
    end
  end
end
