require 'rails_helper'

RSpec.describe Api::V1::SalesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:customer) { FactoryBot.create(:customer) }
  # This should return the minimal set of attributes required to create a valid
  # Sale. As you add validations to Sale, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      notes: "This note is in a sale",
      status: "new_sale",
      total: 12.4,
      customer_id: customer.id,
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      notes: "This note is in a sale",
      status: "lost",
      total: 1.3,
      customer_id: customer.id,
      user_id: user.id,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SalesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
  end

  describe "GET #index" do
    it "returns a success response" do
      Sale.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      sale = Sale.create! valid_attributes
      get :show, params: { id: sale.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Sale" do
        expect {
          post :create, params: { sale: valid_attributes }, session: valid_session
        }.to change(Sale, :count).by(1)
      end

      it "renders a JSON response with the new sale" do
        post :create, params: { sale: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new sale" do
        post :create, params: { sale: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          notes: "This note is in a sale too",
          status: "new_sale",
          total: 41.3,
        }
      }

      it "updates the requested sale" do
        sale = Sale.create! valid_attributes
        put :update, params: { id: sale.to_param, sale: new_attributes }, session: valid_session
        sale.reload
        expect(sale.total).to eq(41.3)
        expect(sale.notes).to include("sale too")
      end

      it "renders a JSON response with the sale" do
        sale = Sale.create! valid_attributes

        put :update, params: { id: sale.to_param, sale: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the sale" do
        sale = Sale.create! valid_attributes

        put :update, params: { id: sale.to_param, sale: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sale" do
      sale = Sale.create! valid_attributes
      expect {
        delete :destroy, params: { id: sale.to_param }, session: valid_session
      }.to change(Sale, :count).by(-1)
    end
  end
end
