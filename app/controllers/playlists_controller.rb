class PlaylistsController < ApplicationController

    before_action :logged_in?, :set_playlist, only: [:show, :edit, :update, :destroy]

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
        if !@playlist 
            flash[:alert] = "This playlist does not exist!"
            redirect_to playlists_path
        end 
        if @playlist.categories.length == 0 || @playlist.songs.length == 0
            flash[:alert] = "No songs have been added to this playlist yet!"
        end 
    end 

    def index 
        @playlists = Playlist.all 
    end 

    def edit 
        if @playlist.nil? || @playlist.user != current_user
            flash[:alert] = "You can't edit another user's playlist!"
            redirect_to playlist_path(@playlist)
        end 
    end 

    def update 
        @playlist.update(playlist_params)
        if @playlist.save
            redirect_to playlist_path(@playlist)
        else 
            render :edit
        end 
    end 

    def destroy 
        if @playlist && @playlist.user == current_user
            @playlist.destroy
            flash[:notice] = "Playlist deleted."
            redirect_to playlists_path
        else 
            flash[:alert] = "You can't delete another user's playlist!"
            redirect_to playlist_path(@playlist)
        end 
    end 

    private 

    def set_playlist
        @playlist = Playlist.find_by(id: params[:id])
    end 

    def playlist_params 
        params.require(:playlist).permit(:name, :description, categories_attributes: [:name, :song_id], songs_attributes: [:title, :artist, :genre])
    end 

end
