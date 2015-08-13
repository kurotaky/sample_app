class Api::MicropostsController < Api::ApplicationController
  def feed_items
    # @feed_items = current_user.feed
    user = User.find_by(email: 'michael@example.com')
    @feed_items = user.microposts
  end
end
