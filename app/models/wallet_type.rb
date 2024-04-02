class WalletType < ApplicationRecord
  has_many :wallets
  validates :name_type, presence: true
  validates :name_type, uniqueness: true

  INVESTMENT = 'Investment'.freeze
  PROFIT = 'Profit'.freeze
  RELEASE = 'Release'.freeze

  WALLET_TYPES = %w[
    Investment
    Profit
    Release
  ].freeze

  public_constant :WALLET_TYPES
end
