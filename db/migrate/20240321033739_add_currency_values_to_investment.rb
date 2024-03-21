class AddCurrencyValuesToInvestment < ActiveRecord::Migration[7.0]
  def change
    add_column :investments, :bitcoin_taken_value, :string
    add_column :investments, :ethereum_taken_value, :string
    add_column :investments, :cardano_taken_value, :string
    add_column :investments, :period, :integer
  end
end
