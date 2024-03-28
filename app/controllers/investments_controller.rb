class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @investment = Investment.new
  end

  def create
    creator = ::Investments::InvestmentCreator.new(investment_params.merge(user_id: current_user.id))

    if creator.call
      redirect_to investments_path, notice: 'Investment was successfully created.'
    else
      flash.now[:alert] = "There was a problem creating the investment."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:amount, :period, :crypto_id)
  end
end
