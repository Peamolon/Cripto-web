class Profit < ApplicationRecord
  belongs_to :wallet
  belongs_to :investment

  include AASM

  aasm column: 'status' do
    state :not_paid, initial: true
    state :paid

    event :pay, after: :update_wallet_balance do
      transitions from: :not_paid, to: :paid
    end
  end

  private

  def update_wallet_balance
    wallet.update!(amount: wallet.amount + self.amount)
  end
end
