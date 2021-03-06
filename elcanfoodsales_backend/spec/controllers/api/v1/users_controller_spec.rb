require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      first_name: "Lorem",
      last_name: "Ipsum",
      password: "sir_dolor_amet",
      password_confirmation: "sir_dolor_amet",
      email: "lorem@ipsum.sir.do",
      type: "User",
    }
  }

  let(:invalid_attributes) {
    {
      first_name: "Lorem",
      last_name: "Ipsum",
      password: "sir_dolor_amet",
      password_confirmation: "sir_dolor_amet",
      email: "lorem@ipsum",
      type: "soret",
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :show, params: { id: user.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: { user: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: { user: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          first_name: "Lorem2",
          last_name: "Ipsuma",
        }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
        user.reload
        expect(user.first_name).to eq("Lorem2")
        expect(user.last_name).to eq("Ipsuma")
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes

        put :update, params: { id: user.to_param, user: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes

        put :update, params: { id: user.to_param, user: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: { id: user.to_param }, session: valid_session
      }.to change(User, :count).by(-1)
    end
  end
end
