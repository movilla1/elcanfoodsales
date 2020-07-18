# frozen_string_literal: true

module Api
  module V1
    class AddressesController < ApplicationController
      before_action :set_address, only: %i[show update destroy]

      # GET /api/v1/addresses
      def index
        @addresses = Address.all
        authorize @addresses
        render json: @addresses
      end

      # GET /api/v1/addresses/1
      def show
        render json: @address
      end

      # POST /api/v1/addresses
      def create
        @address = Address.new(address_params)
        authorize @address
        if @address.save
          render json: @address, status: :created
        else
          render json: @address.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/addresses/1
      def update
        if @address.update(address_params)
          render json: @address
        else
          render json: @address.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/addresses/1
      def destroy
        @address.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_address
        @address = Address.find(params[:id])
        authorize @address
      end

      # Only allow a trusted parameter "white list" through.
      def address_params
        params.require(:address).permit(
          :street,
          :number,
          :appartment,
          :postal_code,
          :province,
          :city,
          :user_id
        )
      end
    end
  end
end
