class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_investment, only: [:release]
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

  def release
    def release
      release_service = Investments::InvestmentReleaseService.new(@investment)

      if release_service.call
        redirect_to wallet_path(current_user.wallet_by_type(WalletType::RELEASE).id), notice: 'Investment was successfully released.'
      else
        redirect_to wallet_path(current_user.wallet_by_type(WalletType::INVESTMENT).id), alert: 'There was a problem releasing the investment.'
      end
    end
  end

  private

  def set_investment
    @investment = Investment.find(params[:id])
  end
  def investment_params
    params.require(:investment).permit(:amount, :period, :crypto_id, :calculated_benefit)
  end
end
