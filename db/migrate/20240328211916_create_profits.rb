class CreateProfits < ActiveRecord::Migration[7.0]
  def change
    create_table :profits do |t|
      t.string :status
      t.decimal "amount"
      t.date :paid_date
      t.references :investment, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
