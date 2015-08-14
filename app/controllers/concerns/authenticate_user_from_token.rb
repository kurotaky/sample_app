module AuthenticateUserFromToken
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_from_token!, except: [:create]
  end

  # emailとtokenを渡して認証
  def authenticate_user_from_token!
    @user = User.find_by(email: params[:email])
    unless @user.try(:authentication_token) &&
           @user.try(:authentication_token) == params[:authentication_token]
      render json: { message: "Login please." }, status: 401
    end
  end
end
