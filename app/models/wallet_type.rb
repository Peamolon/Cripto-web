class WalletType < ApplicationRecord
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
