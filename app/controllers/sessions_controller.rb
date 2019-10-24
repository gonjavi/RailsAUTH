class SessionsController < ApplicationController

    # def create
    #     user = User.find_by(email: params[:session][:email].downcase)
    #     if user && user.authenticate(params[:session][:password])
    #       if user.activated?
    #         log_in user
    #         params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    #         redirect_back_or user
    #       else
    #         message  = "Account not activated. "
    #         message += "Check your email for the activation link."
    #         flash[:warning] = message
    #         redirect_to root_url
    #       end
    #     else
    #       flash.now[:danger] = 'Invalid email/password combination'
    #       render 'new'
    #     end
    #   end
    def new
    end
    def before_create
      self.remember_token = User.new_token
    end
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  
    def destroy
      log_out
      redirect_to root_url
    end

      # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Returns the user corresponding to the remember token cookie.
    def current_user
        if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
            log_in user
            @current_user = user
        end
        end
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
    # Forgets a persistent session.
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

end
