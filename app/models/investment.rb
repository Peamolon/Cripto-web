class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :crypto
  has_many :transactions
  include AASM

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :period, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  aasm column: 'status' do
    state :in_progress, initial: true
    state :finished

    event :complete do
      transitions from: :in_progress, to: :finished
    end
  end
end
