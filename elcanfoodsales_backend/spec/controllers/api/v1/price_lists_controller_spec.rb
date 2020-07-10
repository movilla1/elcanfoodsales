require 'rails_helper'

RSpec.describe Api::V1::PriceListsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # PriceList. As you add validations to PriceList, be sure to
  # adjust the attributes here as well.
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) {
    { name: "Precio justo", status: "active", valid_through: Date.today + 1.week, user_id: user.id }
  }

  let(:invalid_attributes) {
    { name: "Precio justo", status: "zero", valid_through: Date.today.end_of_day, user_id: user.id }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PriceListsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      PriceList.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      price_list = PriceList.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :show, params: { id: price_list.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PriceList" do
        expect {
          request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
          post :create, params: { price_list: valid_attributes }, session: valid_session
        }.to change(PriceList, :count).by(1)
      end

      it "renders a JSON response with the new price_list" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { price_list: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new price_list" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { price_list: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "Precio justo nuevo", status: "active", valid_through: Date.today + 1.day, user_id: user.id }
      }

      it "updates the requested price_list" do
        price_list = PriceList.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: price_list.to_param, price_list: new_attributes }, session: valid_session
        price_list.reload
        expect(price_list.name).to eq("Precio justo nuevo")
        expect(price_list.valid_through).to eq(Date.today + 1.day)
      end

      it "renders a JSON response with the price_list" do
        price_list = PriceList.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: price_list.to_param, price_list: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the price_list" do
        price_list = PriceList.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: price_list.to_param, price_list: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested price_list" do
      price_list = PriceList.create! valid_attributes
      expect {
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        delete :destroy, params: { id: price_list.to_param }, session: valid_session
      }.to change(PriceList, :count).by(-1)
    end
  end
end
