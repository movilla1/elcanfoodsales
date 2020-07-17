require 'rails_helper'

RSpec.describe "Api::V1::SaleLines", type: :request do
  let(:sale) {
    FactoryBot.create(:sale)
  }
  describe "GET /api/v1/sale_lines" do
    it "works! (now write some real specs)" do
      get api_v1_sale_sale_lines_path(sale_id: sale.id), headers: @header
      expect(response).to have_http_status(200)
    end
  end
end
