# frozen_string_literal: true
module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: %i[show update destroy]

      # GET /customers
      def index
        @customers = Customer.all
        authorize @customers
        render json: @customers
      end

      # GET /customers/1
      def show
        render json: @customer
      end

      # POST /customers
      def create
        @customer = Customer.new(customer_params)
        authorize @customer
        if @customer.save
          render json: @customer, status: :created
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /customers/1
      def update
        if @customer.update(customer_params)
          render json: @customer
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /customers/1
      def destroy
        @customer.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id])
        authorize @customer
      end

      # Only allow a trusted parameter "white list" through.
      def customer_params
        params.require(:customer).permit(:name, :birthday, :phone, :email, :pet_name, :pet_type, :user_id)
      end
    end
  end
end
