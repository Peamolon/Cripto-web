module Investments
  class InvestmentCreator
    include ActiveModel::Model

    attr_accessor :amount, :period, :crypto_id, :user_id, :calculated_benefit

    validates :amount, numericality: { greater_than: 0 }
    validates :period, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12 }
    validates :crypto_id, presence: true
    validates :user_id, presence: true

    def initialize(attributes={})
      super
    end

    def call
      return false unless valid?
      ActiveRecord::Base.transaction do
        user = User.find(user_id)
        wallet = user.wallet_by_type(WalletType::INVESTMENT)
        investment = create_investment(wallet)

        return false unless investment

        add_amount_to_wallet(wallet)

        create_profit_transactions(user.id, calculated_benefit, period, investment)

        if user.parent_id.present?
          reward_created = ::Investments::RewardCreator.new(
            investment_id: investment.id,
            referring_user_id: user.parent_id
          ).call

          return false unless reward_created
        end

        true
      end
    rescue => e
      errors.add(:base, e.message)
      false
    end

    private

    def create_profit_transactions(user_id, calculated_total_amount, period, investment)
      ::Investments::ProfitGeneratorService.new(user_id, calculated_total_amount, period, investment).call
    end

    def create_investment(wallet)
      Investment.create!(
        amount: amount,
        period: period,
        crypto_id: crypto_id,
        user_id: user_id,
        start_date: Date.today,
        end_date: period.to_i.months.from_now,
        wallet_id: wallet.id
      )
    end

    def add_amount_to_wallet(wallet)
      new_amount = wallet.amount + amount.to_f
      wallet.update(amount: new_amount)
    end
  end
end
