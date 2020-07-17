# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      # GET /users/1
      def show
        render json: @user
      end

      # POST /users
      def create
        @user = User.new(user_params)
        authorize @user

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      rescue ActiveRecord::SubclassNotFound => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      rescue ArgumentError => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      rescue ActiveRecord::SubclassNotFound => _e
        render json: I18n.t("api.error.invalid_params"), status: :unprocessable_entity
      end

      # DELETE /users/1
      def destroy
        @user.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
        authorize @user
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :phone, :password, :password_confirmation, :email, :type)
      end
    end
  end
end
