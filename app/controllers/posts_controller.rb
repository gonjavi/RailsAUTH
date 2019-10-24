class PostsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create]

    def index
    end

    def new
    end

    def create
    end

    private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
