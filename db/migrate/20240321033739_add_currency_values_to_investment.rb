class AddCurrencyValuesToInvestment < ActiveRecord::Migration[7.0]
  def change
    add_column :investments, :period, :integer
  end
end
