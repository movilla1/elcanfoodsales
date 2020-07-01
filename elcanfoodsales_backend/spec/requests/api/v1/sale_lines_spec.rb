require 'rails_helper'

RSpec.describe "Api::V1::SaleLines", type: :request do
  describe "GET /api/v1/sale_lines" do
    it "works! (now write some real specs)" do
      get sale_lines_path
      expect(response).to have_http_status(200)
    end
  end
end
