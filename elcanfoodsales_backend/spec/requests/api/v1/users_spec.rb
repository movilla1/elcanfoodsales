require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/user/1" do
    it "Gets user details" do
      user = FactoryBot.create(:user)
      get api_v1_user_path(user.id), headers: @header
      expect(response).to have_http_status(200)
      expect(response.body).to include(user.first_name)
    end
  end

  it "PATCH /api/v1/user/1 updates firstname" do
    user = FactoryBot.create(:user)
    patch api_v1_user_path(user.id), { params: { user: { first_name: "LoremIpsum2231" } }, headers: @header }
    expect(response).to have_http_status(200)
    expect(response.body).to include("LoremIpsum2231")
    expect(user.reload.first_name).to eq("LoremIpsum2231")
  end

  it "Destroys the user when an admin requests it" do
    user = FactoryBot.create(:user)
    expect { delete api_v1_user_path(user.id), headers: @header }.to change(User, :count).by(-1)
  end

  it "Won't destroy any user if not admin" do
    user_requesting = FactoryBot.create(:user)
    user = FactoryBot.create(:user)
    delete api_v1_user_path(user.id), headers: auth_header_for(user_requesting)
    expect(response).to have_http_status(:unauthorized)
  end
end
