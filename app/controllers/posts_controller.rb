class PostsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create]

    def index
      #@posts = Post.where(user_id: params[current_user.id])
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      @post.user_id = (current_user.id)
      if @post.save        
        redirect_to posts_path
      else
        flash.now[:danger] = 'Post was not created'
        render 'new'
      end
    end

    def show
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
    
      #params = {user_id: current_user.id}
      params.require(:post).permit(:name, :content)
      
      
    end
end
