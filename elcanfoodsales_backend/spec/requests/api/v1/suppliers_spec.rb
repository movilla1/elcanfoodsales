require 'rails_helper'

RSpec.describe "Api::V1::Suppliers", type: :request do
  describe "GET /api/suppliers" do
    it "works! (now write some real specs)" do
      get api_v1_suppliers_path, headers: @header
      expect(response).to have_http_status(200)
    end
  end
end
