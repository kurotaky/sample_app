class Api::MicropostsController < Api::ApplicationController
  include AuthenticateUserFromToken

  def feed_items
    @feed_items = @user.feed
    render json: @feed_items
  end
end
