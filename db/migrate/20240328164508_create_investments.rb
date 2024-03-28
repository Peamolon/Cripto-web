class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.decimal "amount"
      t.integer "user_id", null: false
      t.integer "crypto_id", null: false
      t.integer "period"
      t.datetime "start_date"
      t.datetime "end_date"
      t.string "status"
      t.index ["user_id"], name: "index_investments_on_user_id"
      t.index ["crypto_id"], name: "index_investments_on_crypto_id"
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
