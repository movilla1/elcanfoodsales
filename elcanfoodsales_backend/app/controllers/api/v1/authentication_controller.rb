# frozen_string_literal: true

module Api
  module V1
    # Auth management
    class AuthenticationController < Api::ApplicationController
      skip_before_action :authenticate_request

      def authenticate
        command = AuthenticateUser.call(
          params[:email], params[:password]
        )

        if command.success?
          render json: { 
            auth_token: command.result,
            user: User.select(:first_name, :last_name, :email).find_by(email: params[:email]),
          }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end
    end
  end
end
