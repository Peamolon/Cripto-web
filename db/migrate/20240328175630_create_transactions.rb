class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :investment, null: true, foreign_key: true
      t.decimal :amount
      t.string :transaction_type
      t.datetime :date

      t.timestamps
    end
  end
end
