class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reward_type
      t.decimal :amount
      t.datetime :awarded_at
      t.references :investment, null: false, foreign_key: true
      t.integer :referring_user_id

      t.timestamps
    end
    add_index :rewards, :referring_user_id
  end
end
