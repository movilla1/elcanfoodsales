module Api
  module V1
    class SalesController < ApplicationController
      before_action :set_sale, only: [:show, :update, :destroy]

      # GET /sales
      def index
        @sales = Sale.all
        authorize @sales
        render json: @sales
      end

      # GET /sales/1
      def show
        render json: @sale
      end

      # POST /sales
      def create
        @sale = Sale.new(sale_params)
        authorize @sale
        if @sale.save
          render json: @sale, status: :created
        else
          render json: @sale.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /sales/1
      def update
        if @sale.update(sale_params)
          render json: @sale
        else
          render json: @sale.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /sales/1
      def destroy
        @sale.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_sale
        @sale = Sale.find(params[:id])
        authorize @sale
      end

      # Only allow a trusted parameter "white list" through.
      def sale_params
        params.require(:sale).permit(:customer_id, :user_id, :total, :notes, :status)
      end
    end
  end
end
