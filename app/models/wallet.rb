class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :wallet_type
  has_many :investments
  has_many :profits

  def type
    wallet_type.name_type
  end
end
