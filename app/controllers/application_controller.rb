class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :signed_in_user, except: [:about]
  before_action :correct_user, only: [:edit, :update]
  include SessionsHelper
end
