require 'test_helper'

module Api
  class MicropostsControllerTest < ActionController::TestCase
    def setup
      users(:michael)
    end

    test "return microposts json array" do
      response = get :feed_items, format: :json
      response_body = JSON.parse response.body
      micropost = {
        id: Integer,
        content: String,
        user_id: 762146111,
        created_at: String,
        updated_at: String,
        picture: wildcard_matcher
      }
      pattern = []
      34.times { pattern << micropost }
      assert_json_match pattern, response_body
    end
  end
end
