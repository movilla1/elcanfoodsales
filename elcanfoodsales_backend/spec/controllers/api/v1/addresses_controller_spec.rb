require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Address. As you add validations to Address, be sure to
  # adjust the attributes here as well.
  let!(:user) {
    FactoryBot.create(:user)
  }

  let(:valid_attributes) {
    {
      street: "Perma Street",
      number: "123",
      appartment: "B",
      postal_code: "5730",
      province: "Salta",
      city: "Mercedes",
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      street: "Perma Street",
      number: "123",
      appartment: "B",
      postal_code: "5730",
      province: "Salta",
      city: nil,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AddressesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      address = Address.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      address = Address.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :show, params: {id: address.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Address" do
        expect {
          request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
          post :create, params: {address: valid_attributes}, session: valid_session
        }.to change(Address, :count).by(1)
      end

      it "renders a JSON response with the new address" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: {address: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new address" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: {address: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          street: "Perma Street",
          number: "765",
          appartment: "A",
          postal_code: "9876",
          province: "Salta",
          city: "Mercedes",
          user_id: user.id,
        }
      }

      it "updates the requested address" do
        address = Address.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {id: address.to_param, address: new_attributes}, session: valid_session
        address.reload
        expect(address.number).to eq("765")
        expect(address.postal_code).to eq("9876")
      end

      it "renders a JSON response with the address" do
        address = Address.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {id: address.to_param, address: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the address" do
        address = Address.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {id: address.to_param, address: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested address" do
      address = Address.create! valid_attributes
      expect {
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        delete :destroy, params: {id: address.to_param}, session: valid_session
      }.to change(Address, :count).by(-1)
    end
  end

end
