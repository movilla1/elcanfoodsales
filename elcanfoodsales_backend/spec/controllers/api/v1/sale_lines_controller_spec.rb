require 'rails_helper'

RSpec.describe Api::V1::SaleLinesController, type: :controller do
  let(:product) { FactoryBot.create(:product) }
  let(:sale) { FactoryBot.create(:sale) }
  let(:user) { FactoryBot.create(:user) }
  # This should return the minimal set of attributes required to create a valid
  # SaleLine. As you add validations to SaleLine, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      quantity: 2,
      status: "new_sale",
      subtotal: 3.5,
      product_id: product.id,
      sale_id: sale.id,
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      quantity: nil,
      status: "shoe",
      subtotal: 3.5,
      product_id: product.id,
      sale_id: sale.id,
      user_id: user.id,
    }
  }

  before do
    request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SaleLinesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      SaleLine.create! valid_attributes
      get :index, params: {sale_id: sale.id}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      sale_line = SaleLine.create! valid_attributes
      get :show, params: {sale_id: sale.id, id: sale_line.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SaleLine" do
        expect {
          post :create, params: {sale_id: sale.id, sale_line: valid_attributes }, session: valid_session
        }.to change(SaleLine, :count).by(1)
      end

      it "renders a JSON response with the new sale_line" do
        post :create, params: {sale_id: sale.id, sale_line: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new sale_line" do
        post :create, params: {sale_id: sale.id, sale_line: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          quantity: 33,
          subtotal: 32.5,
        }
      }

      it "updates the requested sale_line" do
        sale_line = SaleLine.create! valid_attributes
        put :update, params: {sale_id: sale.id, id: sale_line.to_param, sale_line: new_attributes }, session: valid_session
        sale_line.reload
        expect(sale_line.quantity).to eq(33)
        expect(sale_line.subtotal).to eq(32.5)
      end

      it "renders a JSON response with the sale_line" do
        sale_line = SaleLine.create! valid_attributes

        put :update, params: {sale_id: sale.id, id: sale_line.to_param, sale_line: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the sale_line" do
        sale_line = SaleLine.create! valid_attributes

        put :update, params: {sale_id: sale.id, id: sale_line.to_param, sale_line: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sale_line" do
      sale_line = SaleLine.create! valid_attributes
      expect {
        delete :destroy, params: {sale_id: sale.id, id: sale_line.to_param }, session: valid_session
      }.to change(SaleLine, :count).by(-1)
    end
  end
end
