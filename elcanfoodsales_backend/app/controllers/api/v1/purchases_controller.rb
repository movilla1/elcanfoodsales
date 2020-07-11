module Api
  module V1
    class PurchasesController < ApplicationController
      before_action :set_purchase, only: [:show, :update, :destroy]

      # GET /purchases
      def index
        @purchases = Purchase.all
        authorize @purchases
        render json: @purchases
      end

      # GET /purchases/1
      def show
        render json: @purchase
      end

      # POST /purchases
      def create
        @purchase = Purchase.new(purchase_params)
        authorize @purchase
        if @purchase.save
          render json: @purchase, status: :created, location: @purchase
        else
          render json: @purchase.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /purchases/1
      def update
        if @purchase.update(purchase_params)
          render json: @purchase
        else
          render json: @purchase.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /purchases/1
      def destroy
        @purchase.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_purchase
        @purchase = Purchase.find(params[:id])
        authorize @purchase
      end

      # Only allow a trusted parameter "white list" through.
      def purchase_params
        params.require(:purchase).permit(:date, :price, :quantity, :note, :status, :product_id)
      end
    end
  end
end
