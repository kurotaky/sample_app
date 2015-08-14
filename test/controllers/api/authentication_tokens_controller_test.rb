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
  end
end
