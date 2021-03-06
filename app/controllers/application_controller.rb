class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?, :redirect_if_not_playlist, :redirect_if_not_owner

    def home 
    end 

    def current_user
        @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end 

    def logged_in? 
        current_user ? current_user : redirect_to(root_path)
    end

    def redirect_if_not_playlist
        if !@playlist
            flash[:alert] = "This playlist does not exist!"
            redirect_to playlists_path
        end 
    end 

    def redirect_if_not_owner
        if @playlist && @playlist.user != current_user
            flash[:alert] = "This is not your playlist!"
            redirect_to playlists_path 
        end 
    end 

end
