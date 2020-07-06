# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action :authenticate_request
    attr_reader :current_api_user

    private

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      user_not_authorized unless @current_user
    end

    def user_not_authorized
      render json: { error: I18n.t('api.error.unauthorized') },
             status: :unauthorized
    end
  end
end
