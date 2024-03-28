class UpdateProfitStatusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Investment.where('end_date <= ?', Date.today).find_each do |investment|
      investment.complete!
    end

    Profit.where("paid_date <= ?", Date.today).not_paid.find_each do |profit|
      profit.pay!
    end
  end
end