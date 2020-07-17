require 'rails_helper'

RSpec.describe Api::V1::PurchasesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:supplier) { FactoryBot.create(:supplier) }
  let!(:product) { FactoryBot.create(:product) }
  # This should return the minimal set of attributes required to create a valid
  # Purchase. As you add validations to Purchase, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      date: Date.today,
      note: "This is a note lipsum",
      price: 2.5,
      quantity: 5,
      status: "active",
      product_id: product.id,
      supplier_id: supplier.id,
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      date: Date.today,
      note: "This is a note lipsum",
      price: 2.5,
      quantity: nil,
      status: "active",
      product_id: nil,
      supplier_id: supplier.id,
      user_id: user.id,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PurchasesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      purchase = Purchase.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      purchase = Purchase.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :show, params: {id: purchase.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Purchase" do
        expect {
          request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
          post :create, params: { purchase: valid_attributes }, session: valid_session
        }.to change(Purchase, :count).by(1)
      end

      it "renders a JSON response with the new purchase" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: {purchase: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new purchase" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: {purchase: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          date: Date.today - 1.day,
          note: "This is a note lipsum",
          price: 2.225,
          quantity: 6,
          status: "active",
        }
      }

      it "updates the requested purchase" do
        purchase = Purchase.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {id: purchase.to_param, purchase: new_attributes}, session: valid_session
        purchase.reload
        expect(purchase.quantity).to eq(6)
        expect(purchase.price).to eq(2.225)
      end

      it "renders a JSON response with the purchase" do
        purchase = Purchase.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {id: purchase.to_param, purchase: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the purchase" do
        purchase = Purchase.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: {id: purchase.to_param, purchase: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested purchase" do
      purchase = Purchase.create! valid_attributes
      expect {
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        delete :destroy, params: {id: purchase.to_param}, session: valid_session
      }.to change(Purchase, :count).by(-1)
    end
  end

end
