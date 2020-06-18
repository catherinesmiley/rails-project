class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?, :redirect_if_not_current_user

    def home 
    end 

    def current_user
        @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end 

    def logged_in? 
        current_user ? current_user : redirect_to(root_path)
    end

    def redirect_if_not_current_user
        if current_user 
            current_user
        else 
            redirect_to root_path
        end 
    end 

end
