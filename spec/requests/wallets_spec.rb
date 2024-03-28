require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  describe "GET /investment" do
    it "returns http success" do
      get "/wallets/investment"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /profit" do
    it "returns http success" do
      get "/wallets/profit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /release" do
    it "returns http success" do
      get "/wallets/release"
      expect(response).to have_http_status(:success)
    end
  end

end
