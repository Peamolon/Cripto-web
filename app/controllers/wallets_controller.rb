class WalletsController < ApplicationController
  before_action :authenticate_user!
  def show
    @wallet = current_user.wallets.find(params[:id])
    @wallet_type = @wallet.type

    case @wallet.type
    when 'Investment'
      @investments = @wallet.investments.order(created_at: :desc).page(params[:investment_page]).per(10)
      @total_investment = @wallet.investments.sum(:amount)
    when 'Profit'
      @profits = @wallet.profits.order(created_at: :desc).page(params[:profit_page]).per(10)
      @total_profit = @wallet.profits.sum(:amount)
      @total_paid_profit = @wallet.profits.paid.sum(:amount)
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Wallet not found"
  end
end
