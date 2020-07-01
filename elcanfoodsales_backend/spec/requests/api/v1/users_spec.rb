require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/user/1" do
    it "Gets users list" do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      get api_v1_user_path(user.id), headers: @header
      expect(response).to have_http_status(200)
      expect(response.body).to include(user.first_name)
      expect(response.body).not_to include(user2.first_name)
    end
  end

  it "PATCH /api/v1/user/1 updates firstname" do
    user = FactoryBot.create(:user)
    patch api_v1_user_path(user.id), { params: { user: { first_name: "LoremIpsum2231" } }, headers: @header }
    expect(response).to have_http_status(200)
    expect(response.body).to include("LoremIpsum2231")
    expect(user.reload.first_name).to eq("LoremIpsum2231")
  end
end
