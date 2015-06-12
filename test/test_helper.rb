ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper
  include UsersHelper

  def is_logged_in?
    !(session[:user_id].nil?)
  end

  def log_in_as(user, opts = {})
    password    = opts[:password]    || "password"
    remember_me = opts[:remember_me] || "1"
    if integration_test?
      session = {
        email:       user.email,
        password:    password,
        remember_me: remember_me
      }
      post login_path, session: session
    else
      session[:user_id] = user.id
    end
  end

  private

  def integration_test?
    defined? post_via_redirect
  end
end
