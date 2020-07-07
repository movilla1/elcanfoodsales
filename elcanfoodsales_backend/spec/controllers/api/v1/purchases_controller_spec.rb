require 'rails_helper'



RSpec.describe Api::V1::PurchasesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Purchase. As you add validations to Purchase, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PurchasesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      purchase = Purchase.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      purchase = Purchase.create! valid_attributes
      get :show, params: {id: purchase.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Purchase" do
        expect {
          post :create, params: {purchase: valid_attributes}, session: valid_session
        }.to change(Purchase, :count).by(1)
      end

      it "renders a JSON response with the new purchase" do

        post :create, params: {purchase: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(purchase_url(Purchase.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new purchase" do

        post :create, params: {purchase: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested purchase" do
        purchase = Purchase.create! valid_attributes
        put :update, params: {id: purchase.to_param, purchase: new_attributes}, session: valid_session
        purchase.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the purchase" do
        purchase = Purchase.create! valid_attributes

        put :update, params: {id: purchase.to_param, purchase: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the purchase" do
        purchase = Purchase.create! valid_attributes

        put :update, params: {id: purchase.to_param, purchase: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested purchase" do
      purchase = Purchase.create! valid_attributes
      expect {
        delete :destroy, params: {id: purchase.to_param}, session: valid_session
      }.to change(Purchase, :count).by(-1)
    end
  end

end
