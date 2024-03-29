require 'csv'
class CryptocurrenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cryptocurrencies, only: [:index, :export_csv, :export_json]
  def index
    @cryptocurrencies = ::Cryptocurrency::CryptocurrencyService.fetch_cryptocurrencies_info
    @current_user = current_user
  end

  def export_csv
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Name', 'Symbol', 'Price', 'Monthly Return Percentage']
      @cryptocurrencies.each do |crypto|
        csv << [crypto[:name], crypto[:symbol], crypto[:price], crypto[:monthly_return_percentage]]
      end
    end

    send_data csv_data, filename: "cryptocurrencies.csv"
  end

  def export_json
    send_data @cryptocurrencies.to_json, filename: "cryptocurrencies.json"
  end

  private

  def set_cryptocurrencies
    @cryptocurrencies = ::Cryptocurrency::CryptocurrencyService.fetch_cryptocurrencies_info
  end
end
