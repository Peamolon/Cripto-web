module Investments
  class InvestmentCreator
    include ActiveModel::Model

    attr_accessor :amount, :period, :crypto_id, :user_id

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
        investment = create_investment
        return false unless investment

        create_transaction(investment)
        true
      end
    rescue => e
      errors.add(:base, e.message)
      false
    end

    private

    def create_investment
      Investment.create!(
        amount: amount,
        period: period,
        crypto_id: crypto_id,
        user_id: user_id,
        start_date: Date.today,
        end_date: period.to_i.months.from_now
      )
    end

    def create_transaction(investment)
      wallet = User.find(user_id).wallet_by_type(WalletType::INVESTMENT)
      Transaction.create!(
        user_id: user_id,
        investment_id: investment.id,
        wallet_id: wallet.id,
        amount: amount,
        transaction_type: Transaction::INVESTMENT
      )
    end
  end
end
