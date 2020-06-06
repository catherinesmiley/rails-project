class PlaylistsController < ApplicationController

    before_action :logged_in?

    def new 
        @playlist = Playlist.new
    end

    def create 
        @playlist = Playlist.new(playlist_params)
        @playlist.user_id = current_user.id
        if @playlist.save 
            redirect_to playlist_path(@playlist)
        else 
            render :new 
        end 
    end 

    def show 
        @playlist = Playlist.find_by(id: params[:id])
        if !@playlist 
            redirect_to playlists_path
        end 
    end 

    def index 
        @playlists = Playlist.all 
    end 

    private 

    def playlist_params 
        params.require(:playlist).permit(:name, :description)
    end 

end
