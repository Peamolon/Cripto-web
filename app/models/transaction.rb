class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :user
  belongs_to :investment, optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: %w[INVESTMENT PROFIT RELEASE] }

  INVESTMENT = 'Investment'.freeze
  PROFIT = 'Profit'.freeze
  RELEASE = 'Release'.freeze

  TRANSACTION_TYPES = [
    INVESTMENT,
    PROFIT,
    RELEASE
  ].freeze
  public_constant :TRANSACTION_TYPES


end
