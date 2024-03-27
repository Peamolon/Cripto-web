require 'rails_helper'

RSpec.describe "Children", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/children/index"
      expect(response).to have_http_status(:success)
    end
  end

end
