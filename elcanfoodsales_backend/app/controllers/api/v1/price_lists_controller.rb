module Api
  module V1
    class PriceListsController < ApplicationController
      before_action :set_price_list, only: [:show, :update, :destroy]

      # GET /price_lists
      def index
        @price_lists = PriceList.all
        authorize @price_lists
        render json: @price_lists
      end

      # GET /price_lists/1
      def show
        render json: @price_list
      end

      # POST /price_lists
      def create
        @price_list = PriceList.new(price_list_params)
        authorize @price_list
        if @price_list.save
          render json: @price_list, status: :created
        else
          render json: @price_list.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /price_lists/1
      def update
        if @price_list.update(price_list_params)
          render json: @price_list
        else
          render json: @price_list.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /price_lists/1
      def destroy
        @price_list.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_price_list
        @price_list = PriceList.find(params[:id])
        authorize @price_list
      end

      # Only allow a trusted parameter "white list" through.
      def price_list_params
        params.require(:price_list).permit(:name, :status, :user_id, :valid_through)
      end
    end
  end
end
