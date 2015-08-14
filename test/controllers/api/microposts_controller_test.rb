require 'test_helper'

module Api
  class MicropostsControllerTest < ActionController::TestCase
    def setup
      users(:michael)
    end

    test "return microposts json array" do
      user = User.find_by(email: 'michael@example.com')
      token = user.generate_authentication_token
      response = get :feed_items ,{ email: 'michael@example.com', authentication_token: token }
      response_body = JSON.parse response.body
      micropost = {
        id: Integer,
        content: String,
        user_id: Integer,
        created_at: String,
        updated_at: String,
        picture: wildcard_matcher
      }
      pattern = []
      36.times { pattern << micropost }
      assert_json_match pattern, response_body
    end
  end
end
