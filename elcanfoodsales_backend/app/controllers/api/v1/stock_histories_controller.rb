# frozen_string_literal: true

module Api
  module V1
    class StockHistoryHistoriesController < ApplicationController
      before_action :set_stock_history, only: %i[show update destroy]

      # GET /stock_histories
      def index
        @stock_histories = StockHistory.all

        render json: @stock_histories
      end

      # GET /stock_histories/1
      def show
        render json: @stock_history
      end

      # POST /stock_histories
      def create
        @stock_history = StockHistory.new(stock_history_params)

        if @stock_history.save
          render json: @stock_history, status: :created, location: @stock_history
        else
          render json: @stock_history.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /stock_histories/1
      def update
        if @stock_history.update(stock_history_params)
          render json: @stock_history
        else
          render json: @stock_history.errors, status: :unprocessable_entity
        end
      end

      # DELETE /stock_histories/1
      def destroy
        @stock_history.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_stock_history
        @stock_history = StockHistory.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def stock_history_params
        params.require(:stock_history).permit(:quantity, :product_id)
      end
    end
  end
end
