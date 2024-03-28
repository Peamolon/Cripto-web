class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @investment = Investment.new
  end

  def create
    creator = ::Investments::InvestmentCreator.new(investment_params.merge(user_id: current_user.id))

    if creator.call
      redirect_to wallet_path(current_user.wallet_by_type(WalletType::INVESTMENT).id), notice: 'Investment was successfully created.'
    else
      @investment = creator
      @cryptocurrencies = Crypto.all
      flash.now[:alert] = creator.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:amount, :period, :crypto_id, :calculated_benefit)
  end
end
