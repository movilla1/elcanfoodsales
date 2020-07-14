module Api
  module V1
    class PricesController < ApplicationController
      before_action :set_price, only: [:show, :update, :destroy]
      before_action :set_price_list
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
        @price = @prices.price.build(price_params)
        authorize @price
        if @price.save
          render json: @price, status: :created, location: @price
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /prices/1
      def update
        if @price.update(price_params)
          render json: @price
        else
          render json: @price.errors, status: :unprocessable_entity
        end
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
        params.require(:price).permit(:product_id, :user_id, :price, :status, :valid_until)
      end

      def set_price_list
        @price_list = PriceList.find(params[:price_list_id])
      end
    end
  end
end
