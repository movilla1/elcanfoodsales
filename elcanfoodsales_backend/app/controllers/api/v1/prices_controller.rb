module Api
  module V1
    class PricesController < ApplicationController
      before_action :set_price_list
      before_action :set_price, only: [:show, :update, :destroy]

      # GET /prices
      def index
        @prices = @price_list.prices.all
        authorize @prices
        render json: @prices
      end

      # GET /prices/1
      def show
        render json: @price
      end

      # POST /prices
      def create
        @price = @price_list.prices.build(price_params)
        authorize @price
        if @price.save
          render json: @price, status: :created
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /prices/1
      def update
        if @price.update(price_params)
          render json: @price
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /prices/1
      def destroy
        @price.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_price
        @price = @price_list.prices.find(params[:id])
        authorize @price
      end

      # Only allow a trusted parameter "white list" through.
      def price_params
        params.require(:price).permit(:product_id, :user_id, :price, :status, :valid_until, :price_list_id)
      end

      def set_price_list
        @price_list = PriceList.find(params[:price_list_id])
        raise RecordNotFound.new("Failed to load price_list") if @price_list.blank?
      end
    end
  end
end
