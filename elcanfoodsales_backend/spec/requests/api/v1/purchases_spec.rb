require 'rails_helper'

RSpec.describe "Api::V1::Purchases", type: :request do
  describe "GET /api/v1/purchases" do
    it "works! (now write some real specs)" do
      get api_v1_purchases_path, headers: @header
      expect(response).to have_http_status(200)
    end
  end
end
