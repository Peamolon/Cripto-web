class AddCryptoTakenValueToInvestment < ActiveRecord::Migration[7.0]
  def change
    add_column :investments, :crypto_taken_value, :float
  end
end
