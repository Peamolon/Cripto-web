class InvestmentsController < ApplicationController
  def new
    @investment = Investment.new
  end

  def create
    flash[:alert] = "Funciona melo"
    redirect_to root_path


  end

  private

  def investment_params
    params.require(:investment).permit(:amount, :period, :calculated_crypto_quantity, :crypto_id, :calculated_benefit, :calculated_total_amount)
  end
end
