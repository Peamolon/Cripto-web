class CreateWalletTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :wallet_types do |t|
      t.string :name_type

      t.timestamps
    end
  end
end
