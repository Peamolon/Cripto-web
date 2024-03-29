class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :crypto
  belongs_to :wallet
  has_many :profits
  has_many :rewards, dependent: :destroy
  include AASM

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :period, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  aasm column: 'status' do
    state :in_progress, initial: true
    state :finished
    state :released

    event :complete, after: :pay_all_profits do
      transitions from: :in_progress, to: :finished
    end

    event :release, after: :update_wallet_amount do
      transitions from: :finished, to: :released
    end
  end

  private

  def update_wallet_amount
    updated_amount =  (wallet.amount - self.amount).to_f
    wallet.update!(amount: updated_amount)

    release_all_profits
  end
  def release_all_profits
    profits.map(&:release!)
  end

  def pay_all_profits
    profits.not_paid.map(&:pay!)
  end
end
