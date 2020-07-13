require 'rails_helper'

RSpec.describe "Api::V1::PriceList::Prices", type: :request do
  describe "Get Index" do
    it "works! (now write some real specs)" do
      get api_v1_price_list_prices_path(price_list_id: 1), headers: @header
      expect(response).to have_http_status(200)
    end
  end
end
