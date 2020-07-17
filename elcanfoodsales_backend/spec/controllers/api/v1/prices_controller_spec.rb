require 'rails_helper'

RSpec.describe Api::V1::PricesController, type: :controller do
  let(:product) { FactoryBot.create(:product) }
  let(:price_list) { FactoryBot.create(:price_list) }
  let(:user) { FactoryBot.create(:user) }
  # This should return the minimal set of attributes required to create a valid
  # Price. As you add validations to Price, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      price: 1.45,
      status: "active",
      price_list_id: price_list.id,
      product_id: product.id,
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      price: 0.0,
      status: "zeroed",
      price_list_id: price_list.id,
      product_id: product.id,
      user_id: user.id,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PricesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Price.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :index, params: { price_list_id: price_list.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      price = Price.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :show, params: { price_list_id: price_list.id, id: price.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Price" do
        expect {
          request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
          post :create, params: {price_list_id: price_list.id, price: valid_attributes}, session: valid_session
        }.to change(Price, :count).by(1)
      end

      it "renders a JSON response with the new price" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: {price_list_id: price_list.id, price: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new price" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: {price_list_id: price_list.id, price: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          price: 2.45,
          status: "active",
        }
      }

      it "updates the requested price" do
        price = Price.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {price_list_id: price_list.id, id: price.to_param, price: new_attributes}, session: valid_session
        price.reload
        expect(price.price).to eq(2.45)
      end

      it "renders a JSON response with the price" do
        price = Price.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {price_list_id: price_list.id, id: price.to_param, price: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the price" do
        price = Price.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {price_list_id: price_list.id, id: price.to_param, price: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested price" do
      price = Price.create! valid_attributes
      expect {
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        delete :destroy, params: {price_list_id: price_list.id, id: price.to_param}, session: valid_session
      }.to change(Price, :count).by(-1)
    end
  end

end
