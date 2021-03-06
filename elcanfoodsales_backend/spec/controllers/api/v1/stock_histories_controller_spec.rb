require 'rails_helper'



RSpec.describe Api::V1::StockHistoriesController, type: :controller do
  let!(:product) {
    FactoryBot.create(:product)
  }
  let!(:user) {
    FactoryBot.create(:user)
  }
  # This should return the minimal set of attributes required to create a valid
  # StockHistory As you add validations to Stock, be sure to
  # adjust the attributes here as well.
  let!(:valid_attributes) {
    { operation: 'add', quantity: 15, product_id: product.id, user_id: user.id }
  }

  let!(:invalid_attributes) {
    { operation: 'zero', quantity: -5, product_id: product.id, user_id: user.id }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StocksController. Be sure to keep this updated too.

  describe "GET #index" do
    it "returns a success response" do
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      stock = StockHistory.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      stock = StockHistory.create! valid_attributes
      get :show, params: { id: stock.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Stock" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        expect {
          post :create, params: { stock_history: valid_attributes }
        }.to change(StockHistory, :count).by(1)
      end

      it "renders a JSON response with the new stock" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { stock_history: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new stock" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { stock_history: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { operation: 'reconcile', quantity: 11 }
      }

      it "updates the requested stock" do
        stock = StockHistory.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: stock.id, stock_history: new_attributes }
        expect(stock.reload.reconcile?).to eq(true)
        expect(stock.quantity).to eq(11)
      end

      it "renders a JSON response with the stock" do
        stock = StockHistory.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: stock.to_param, stock_history: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the stock" do
        stock = StockHistory.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: stock.to_param, stock_history: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested stock" do
      stock = StockHistory.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      expect {
        delete :destroy, params: { id: stock.to_param }
      }.to change(StockHistory, :count).by(-1)
    end
  end
end
