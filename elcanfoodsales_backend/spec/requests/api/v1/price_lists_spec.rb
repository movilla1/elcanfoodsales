require 'rails_helper'

RSpec.describe "Api::V1::PriceLists", type: :request do
  describe "GET /api/v1/price_lists" do
    it "works! (now write some real specs)" do
      get api_v1_price_lists_path, headers: @header
      expect(response).to have_http_status(200)
    end
  end
end
