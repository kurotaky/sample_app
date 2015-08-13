class Api::MicropostsController < Api::ApplicationController
  def feed_items
    # @feed_items = current_user.feed
    user = User.find_by(email: 'michael@example.com')
    # user = User.first
    @feed_items = user.microposts
  end
end
