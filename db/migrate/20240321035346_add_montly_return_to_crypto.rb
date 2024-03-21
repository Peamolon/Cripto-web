class AddMontlyReturnToCrypto < ActiveRecord::Migration[7.0]
  def change
    add_column :cryptos, :monthly_return, :float
  end
end
