class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.decimal :profit_amount
      t.decimal :amount
      t.date :received_at
      t.references :wallet, null: false, foreign_key: true
      t.references :investment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
