class AddEndDateAndStatusToInvestment < ActiveRecord::Migration[7.0]
  def change
    add_column :Investments, :start_date, :date
    add_column :Investments, :end_date, :date
    add_column :Investments, :status, :string
  end
end
