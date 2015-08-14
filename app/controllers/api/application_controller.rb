module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    include SessionsHelper

    before_action :authenticate_user_from_token! #, if: -> { params[:email].present? }

    def basic_auth
      authenticate_or_request_with_http_basic do |name, password|
        @user = User.find_by(name: name)
        if @user && @user.authenticate(password)
          render text: "Login successful!", status: 200
        else
          render text: "Login failed.", status: 401
        end
      end
    end

    def authenticate_user_from_token!
      user = User.find_by(email: params[:email])
      if user.try(:authentication_token) && user.try(:authentication_token) == params[:token]
        log_in user
      end
    end
  end
end
