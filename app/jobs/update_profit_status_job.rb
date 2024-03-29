class UpdateProfitStatusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Investment.where('end_date <= ?', Time.now).find_each do |investment|
      investment.complete!
    end

    Profit.where("paid_date <= ?", Time.now).not_paid.find_each do |profit|
      profit.pay!
    end
  end
end