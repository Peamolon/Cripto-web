class Profit < ApplicationRecord
  belongs_to :wallet
  belongs_to :investment

  include AASM

  aasm column: 'status' do
    state :not_paid, initial: true
    state :paid
    state :released

    event :pay, after: :update_wallet_balance do
      transitions from: :not_paid, to: :paid
    end

    event :release, after: :remove_wallet_balance do #Arreglar el callback
      transitions from: :paid, to: :released
    end
  end

  private

  def remove_wallet_balance
    wallet.update!(amount: wallet.amount - self.amount)
  end

  def update_wallet_balance
    wallet.update!(amount: wallet.amount + self.amount)
  end
end
