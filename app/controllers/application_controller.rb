class ApplicationController < ActionController::Base
    # force user to redirect to login page if logged out
    before_action :authenticate_user!
end
