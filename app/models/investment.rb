class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :crypto

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :period, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
