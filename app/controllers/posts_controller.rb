class PostsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create]

    def index
      @user = current_user
      @posts = params[:user_id].nil? ? Post.all_posts : @user.posts.all_posts
    end

    def new
      @post = @user.posts.build
    end

    def create
      @user =  current_user
      @post = @user.posts.new(post_params)
     if @post.save        
        redirect_to post_path
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
