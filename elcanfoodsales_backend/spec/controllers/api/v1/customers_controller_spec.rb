require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Customer. As you add validations to Customer, be sure to
  # adjust the attributes here as well.
  let!(:user) {
    FactoryBot.create(:user)
  }

  let(:valid_attributes) {
    {
      birthday: Date.new(1979, 7, 27),
      email: 'testing@here.com',
      name: 'mario',
      pet_name: 'gala',
      pet_type: 'dog',
      phone: '345-6789',
      user_id: user.id,
    }
  }

  let(:invalid_attributes) {
    {
      birthday: Date.new(1979, 7, 27),
      email: 'testing@here.com',
      name: 'mario',
      pet_name: 'tuquer',
      pet_type: 'scorpion',
      phone: '345-6789',
      user_id: user.id,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CustomersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      customer = Customer.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      customer = Customer.create! valid_attributes
      request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
      get :show, params: { id: customer.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Customer" do
        expect {
          request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
          post :create, params: { customer: valid_attributes }, session: valid_session
        }.to change(Customer, :count).by(1)
      end

      it "renders a JSON response with the new customer" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { customer: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new customer" do
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        post :create, params: { customer: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          email: 'mario+testing@here.com',
          name: 'mario v.',
          pet_name: 'milo',
          pet_type: 'dog',
          phone: '345-6789',
          user_id: user.id,
        }
      }

      it "updates the requested customer" do
        customer = Customer.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: customer.to_param, customer: new_attributes }, session: valid_session
        customer.reload
        expect(customer.name).to eq("mario v.")
        expect(customer.pet_name).to eq("milo")
      end

      it "renders a JSON response with the customer" do
        customer = Customer.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: customer.to_param, customer: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the customer" do
        customer = Customer.create! valid_attributes
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        put :update, params: { id: customer.to_param, customer: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested customer" do
      customer = Customer.create! valid_attributes
      expect {
        request.headers['Authorization'] = JsonWebToken.encode(user_id: @admin.id)
        delete :destroy, params: { id: customer.to_param }, session: valid_session
      }.to change(Customer, :count).by(-1)
    end
  end
end
