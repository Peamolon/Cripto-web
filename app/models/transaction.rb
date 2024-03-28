class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :user
  belongs_to :investment, optional: true
  belongs_to :investment, optional: true

  validates :transaction_type, presence: true, inclusion: { in: %w[Investment Profit Profit] }

  INVESTMENT = 'Investment'.freeze
  PROFIT = 'Profit'.freeze
  RELEASE = 'Profit'.freeze

  TRANSACTION_TYPES = [
    INVESTMENT,
    PROFIT,
    RELEASE
  ].freeze
  public_constant :TRANSACTION_TYPES


end
