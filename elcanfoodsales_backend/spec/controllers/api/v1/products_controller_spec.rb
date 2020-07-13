require 'rails_helper'
require 'stringio'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let!(:user) {
    FactoryBot.create(:user)
  }
  let(:file) { fixture_file_upload('tmp/supermario-baloons.jpg') }
  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      description: "Sed purus justo, pulvinar at justo et, tristique lacinia tortor.",
      name: "Funny name",
      quantity: 4,
      size: "10k",
      status: "active",
      weight: 10,
      user_id: user.id,
      image: file,
    }
  }

  let(:invalid_attributes) {
    {
      description: "Failed description text",
      name: "Funny name",
      quantity: -1,
      size: "10k",
      status: "active",
      weight: 0,
      user_id: user.id,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Product.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :show, params: { id: product.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
          post :create, params: { product: valid_attributes }, session: valid_session
        }.to change(Product, :count).by(1)
      end

      it "renders a JSON response with the new product" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { product: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new product" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { product: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          description: "Lorem ipsum sir dolor amet",
          name: "Fixed name",
          quantity: 4,
          size: "10k",
          status: "active",
          weight: 10,
          user_id: user.id,
        }
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: product.to_param, product: new_attributes }, session: valid_session
        product.reload
        expect(product.name).to eq("Fixed name")
        expect(product.description).to eq("Lorem ipsum sir dolor amet")
      end

      it "renders a JSON response with the product" do
        product = Product.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: product.to_param, product: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the product" do
        product = Product.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: product.to_param, product: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        delete :destroy, params: { id: product.to_param }, session: valid_session
      }.to change(Product, :count).by(-1)
    end
  end
end
