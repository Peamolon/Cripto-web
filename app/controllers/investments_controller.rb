class InvestmentsController < ApplicationController
  def new
    @investment = Investment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @investment = ::Investments::InvestmentService.call(investment_params)

  end

  private

  def investment_params
    params.require(:investment).permit(:amount)
  end
end
