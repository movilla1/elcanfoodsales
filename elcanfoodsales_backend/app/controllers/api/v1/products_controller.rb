module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]

      # GET /products
      def index
        @products = Product.all.with_attached_image.order(id: :desc)
        authorize @products
        render json: @products
      end

      # GET /products/1
      def show
        render json: @product.to_json
      end

      # POST /products
      def create
        @product = Product.new(product_params)
        authorize @product
        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /products/1
      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /products/1
      def destroy
        @product.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
        authorize @product
      end

      # Only allow a trusted parameter "white list" through.
      def product_params
        params.require(:product).permit(:name, :image, :description, :size, :weight, :user_id, :status, :quantity)
      end
    end
  end
end
