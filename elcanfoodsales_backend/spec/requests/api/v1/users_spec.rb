require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/users" do
    it "works! (now write some real specs)" do
      user = FactoryBot.create(:user)
      get api_v1_user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
