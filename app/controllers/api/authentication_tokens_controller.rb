module Api
  class AuthenticationTokensController < Api::ApplicationController

    def update
      token = current_user.generate_authentication_token
      render json: {token: token}
    end

    def destroy
      current_user.delete_authentication_token
      render nothing: true
    end

    def create
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        token = @user.generate_authentication_token
        render json: { authentication_token: token }, status: 200
      else
        render json: { message: "Login failed." }, status: 401
      end
    end

  end
end
