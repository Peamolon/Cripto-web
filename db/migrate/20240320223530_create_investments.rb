class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.decimal :amount
      t.decimal :bitcoin_return
      t.decimal :ether_return
      t.decimal :cardano_return

      t.timestamps
    end
  end
end
