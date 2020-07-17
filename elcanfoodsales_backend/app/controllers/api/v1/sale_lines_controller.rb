module Api
  module V1
    class SaleLinesController < ApplicationController
      before_action :set_sale_line, only: [:show, :update, :destroy]
      before_action :set_sale

      # GET /sale_lines
      def index
        @sale_lines = @sale.sale_lines.all
        authorize @sale_lines
        render json: @sale_lines
      end

      # GET /sale_lines/1
      def show
        render json: @sale_line
      end

      # POST /sale_lines
      def create
        @sale_line = @sale.sale_lines.build(sale_line_params)
        authorize @sale_line
        if @sale_line.save
          render json: @sale_line, status: :created, location: @sale_line
        else
          render json: @sale_line.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /sale_lines/1
      def update
        if @sale_line.update(sale_line_params)
          render json: @sale_line
        else
          render json: @sale_line.errors, status: :unprocessable_entity
        end
      end

      # DELETE /sale_lines/1
      def destroy
        @sale_line.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_sale_line
        @sale_line = @sale.sale_lines.find(params[:id])
        authorize @sale_line
      end

      # Only allow a trusted parameter "white list" through.
      def sale_line_params
        params.require(:sale_line).permit(:product_id, :quantity, :subtotal, :sale_id, :status)
      end

      def set_sale
        @sale = Sale.find(params[:sale_id])
      end
    end
  end
end
