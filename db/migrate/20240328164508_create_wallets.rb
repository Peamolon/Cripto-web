class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :name
      t.decimal "amount", precision: 10, scale: 2, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :wallet_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
