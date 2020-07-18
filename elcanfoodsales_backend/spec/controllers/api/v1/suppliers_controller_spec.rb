require 'rails_helper'

RSpec.describe Api::V1::SuppliersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  # This should return the minimal set of attributes required to create a valid
  # Supplier. As you add validations to Supplier, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      address: "Lorem 123",
      contact_name: "Ipsum",
      date_start: Date.today - 1.week,
      email: "ipsum@lorem.com",
      name: "Sir Dolor",
      phone: "555-5555",
      status: "active",
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      address: "Lorem 123",
      contact_name: "Ipsum",
      date_start: Date.today,
      email: "ipsum@loremcom",
      name: "Sir Dolor",
      phone: "555-5555",
      status: "zoomed!",
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuppliersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
  end

  describe "GET #index" do
    it "returns a success response" do
      supplier = Supplier.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      supplier = Supplier.create! valid_attributes
      get :show, params: { id: supplier.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Supplier" do
        expect {
          post :create, params: { supplier: valid_attributes }, session: valid_session
        }.to change(Supplier, :count).by(1)
      end

      it "renders a JSON response with the new supplier" do
        post :create, params: { supplier: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new supplier" do
        post :create, params: { supplier: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          address: "Lorem 1234",
          contact_name: "Ipsum4",
          email: "ipsum2@lorem.com",
        }
      }

      it "updates the requested supplier" do
        supplier = Supplier.create! valid_attributes
        put :update, params: { id: supplier.to_param, supplier: new_attributes }, session: valid_session
        supplier.reload
        expect(supplier.address).to eq("Lorem 1234")
        expect(supplier.contact_name).to eq("Ipsum4")
        expect(supplier.email).to eq("ipsum2@lorem.com")
      end

      it "renders a JSON response with the supplier" do
        supplier = Supplier.create! valid_attributes

        put :update, params: { id: supplier.to_param, supplier: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the supplier" do
        supplier = Supplier.create! valid_attributes

        put :update, params: { id: supplier.to_param, supplier: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested supplier" do
      supplier = Supplier.create! valid_attributes
      expect {
        delete :destroy, params: { id: supplier.to_param }, session: valid_session
      }.to change(Supplier, :count).by(-1)
    end
  end
end
