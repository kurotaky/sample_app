require 'test_helper'

module Api
  class AuthenticationTokensControllerTest < ActionController::TestCase
    def setup
      users(:michael)
    end

    test "create authentication token" do
      response = post :create, {email: 'michael@example.com', password: 'password'}
      assert_equal 200, response.status
      response_body = JSON.parse response.body
      assert_match(/\A[a-zA-Z0-9_-]{22}\z/, response_body["authentication_token"])
    end

    test "Login failed when invalid email" do
      response = post :create, {email: 'mich@example.com', password: 'password'}
      assert_equal 401, response.status
      response_body = JSON.parse response.body
      assert_equal 'Login failed.', response_body["message"]
    end

    test "Login failed when invalid password" do
      response = post :create, {email: 'michael@example.com', password: 'passw0rd'}
      assert_equal 401, response.status
      response_body = JSON.parse response.body
      assert_equal 'Login failed.', response_body["message"]
    end

    test "Logout Failed when authentication token is blank" do
      response = delete :destroy, { email: 'michael@example.com' }
      assert_equal 401, response.status
    end

    test "Logout successful with authentication token" do
      response = post :create, { email: 'michael@example.com', password: 'password' }
      assert_equal 200, response.status
      response_body = JSON.parse response.body
      token = response_body["authentication_token"]
      assert_match(/\A[a-zA-Z0-9_-]{22}\z/, token)
      response_destroy = delete :destroy, { email: 'michael@example.com', authentication_token: token }
      assert_equal 200, response_destroy.status
      user = User.find_by(email: 'michael@example.com')
      assert_nil user.try(:authentication_token)
    end

    test "Failed token update when authentication token is blank" do
      response = patch :update, { email: 'michael@example.com' }
      assert_equal 401, response.status
    end

    test "Authentication token update" do
      response = post :create, { email: 'michael@example.com', password: 'password' }
      assert_equal 200, response.status
      response_body = JSON.parse response.body
      token = response_body["authentication_token"]
      assert_match(/\A[a-zA-Z0-9_-]{22}\z/, token)
      response_update = patch :update, { email: 'michael@example.com', authentication_token: token }
      assert_equal 200, response_update.status
      user = User.find_by(email: 'michael@example.com')
      assert_not_equal user.try(:authentication_token), token
    end
  end
end
