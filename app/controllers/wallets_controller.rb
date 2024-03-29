require 'csv'
class WalletsController < ApplicationController
  before_action :authenticate_user!
  def show

    puts "Perroooo: #{params.inspect}"
    @wallet = current_user.wallets.find(params[:id])
    @wallet_type = @wallet.type

    case @wallet.type
    when 'Investment'
      investments = @wallet.investments.order(created_at: :desc)
      if params[:crypto_id].present?
        @investments = Investment.where(crypto_id: params[:crypto_id]).includes(:crypto)
      else
        @investments = Investment.all.includes(:crypto)
      end

      @investments = investments.page(params[:investment_page]).per(10)
    when 'Profit'
      @profits = @wallet.profits.order(created_at: :desc).page(params[:profit_page]).per(10)
      @total_profit = @wallet.profits.sum(:amount)
      @total_paid_profit = @wallet.profits.paid.sum(:amount)
    when 'Release'
      @releases = @wallet.releases.order(created_at: :desc).page(params[:profit_page]).per(10)
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Wallet not found"
  end

  def export_investments_to_csv
    @wallet = current_user.wallets.find(params[:id])
    @investments = @wallet.investments

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Crypto Name', 'Amount Invested', 'Period (months)', 'Start Date', 'End Date', 'Status']
      @investments.each do |investment|
        csv << [
          investment.crypto.name,
          investment.amount,
          investment.period,
          investment.start_date.strftime("%Y-%m-%d"),
          investment.end_date.strftime("%Y-%m-%d"),
          investment.status.capitalize
        ]
      end
    end

    send_data csv_data, filename: "wallet-#{params[:id]}-investments-#{Date.today}.csv"
  end


  def export_investments_to_json
    @investments = current_user.wallets.find(params[:id]).investments
    send_data @investments.to_json, filename: "investments-#{Date.today}.json"
  end

  def export_profits_to_csv
    @wallet = current_user.wallets.find(params[:id])
    @profits = @wallet.profits

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Investment Crypto Name', 'Profit Amount', 'Paid Date', 'Status']
      @profits.each do |profit|
        csv << [
          profit.investment.crypto.name,
          profit.amount,
          profit.paid_date.strftime("%Y-%m-%d"),
          profit.status.capitalize
        ]
      end
    end

    send_data csv_data, filename: "wallet-#{params[:id]}-profits-#{Date.today}.csv"
  end

  def export_profits_to_json
    @wallet = current_user.wallets.find(params[:id])
    @profits = @wallet.profits

    send_data @profits.to_json, filename: "wallet-#{params[:id]}-profits-#{Date.today}.json"
  end


  def export_releases_to_csv
    @wallet = current_user.wallets.find(params[:id])
    @releases = @wallet.releases

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Release Amount', 'Profit Included', 'Release Date']
      @releases.each do |release|
        csv << [
          release.amount,
          release.profit_amount,
          release.created_at.strftime("%Y-%m-%d")
        ]
      end
    end

    send_data csv_data, filename: "wallet-#{params[:id]}-releases-#{Date.today}.csv"
  end

  def export_releases_to_json
    @wallet = current_user.wallets.find(params[:id])
    @releases = @wallet.releases

    send_data @releases.to_json, filename: "wallet-#{params[:id]}-releases-#{Date.today}.json"
  end




end
