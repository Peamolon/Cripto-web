class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :crypto
  belongs_to :wallet
  has_many :profits
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
  end

  private

  def pay_all_profits
    profits.map(&:pay!)
  end
end
