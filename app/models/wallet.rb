class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :wallet_type

  def type
    wallet_type.name_type
  end
end
