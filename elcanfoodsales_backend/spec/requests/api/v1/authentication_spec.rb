require 'rails_helper'

RSpec.describe "Api::V1::Authentication", type: :request do
  before do
    User.create!(
      password: "testing123",
      password_confirmation: "testing123",
      email: "lipsum@here.com",
      first_name: "Testing",
      last_name: "Authentication",
      type: "User"
    )
  end

  describe "Authenticate" do
    it "authenticates properly" do
      post "/api/v1/authenticate", params: { email: "lipsum@here.com", password: "testing123" }
      expect(response.status).to eq(200)
      expect(response.body).to include("auth_token")
    end

    it "Fails to authenticate" do
      post "/api/v1/authenticate", params: { email: "lipsum@here.com", password: "testing111" }
      expect(response.status).to eq(401)
      expect(response.body).not_to include("auth_token")
    end
  end
end
