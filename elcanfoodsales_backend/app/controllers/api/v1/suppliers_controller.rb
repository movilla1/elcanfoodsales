module Api
  module V1
    class SuppliersController < ApplicationController
      before_action :set_supplier, only: [:show, :update, :destroy]

      # GET /suppliers
      def index
        @suppliers = Supplier.all

        render json: @suppliers
      end

      # GET /suppliers/1
      def show
        render json: @supplier
      end

      # POST /suppliers
      def create
        @supplier = Supplier.new(supplier_params)

        if @supplier.save
          render json: @supplier, status: :created
        else
          render json: @supplier.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /suppliers/1
      def update
        if @supplier.update(supplier_params)
          render json: @supplier
        else
          render json: @supplier.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /suppliers/1
      def destroy
        @supplier.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_supplier
          @supplier = Supplier.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def supplier_params
          params.require(:supplier).permit(:date_start, :name, :phone, :email, :contact_name, :status, :user_id, :address)
        end
    end
  end
end
