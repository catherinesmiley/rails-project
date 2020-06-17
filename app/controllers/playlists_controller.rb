class PlaylistsController < ApplicationController

    before_action :logged_in?

    def new 
        @playlist = Playlist.new
        @playlist.songs.build
        @playlist.songs.first.categories.build
    end

    def create 
        @playlist = Playlist.new(playlist_params)
        @playlist.user_id = current_user.id
        # @playlist.songs.last.categories.last.playlist = @playlist
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
        params.require(:playlist).permit(:name, :description, categories_attributes:[:name, :song_id], songs_attributes: [:title, :artist, :genre, categories_attributes: [:name]])
    end 

end
