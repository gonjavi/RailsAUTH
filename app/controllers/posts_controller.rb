class PostsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create]

    def index
    end

    def new
      @post = Post.new

    end

    def create
      #CURRENTLY WORKING IN HERE
      # post = Post.create(post_params)
      # redirect_to post
    end

    private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def set_user
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :content)
    end
end
