module Api
  class ApplicationController < ActionController::Base
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
  end
end
