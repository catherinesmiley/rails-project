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
        redirect_if_not_playlist
    end 

    def index 
        @playlists = Playlist.all 
    end 

    def edit 
        redirect_if_not_playlist
        redirect_if_not_owner
    end 

    def update 
        @playlist.update(playlist_params)
        if @playlist.save
            flash[:notice] = "Playlist updated."
            redirect_to playlist_path(@playlist)
        else 
            render :edit
        end 
    end 

    def destroy 
        @playlist.destroy
        flash[:notice] = "Playlist deleted."
        redirect_to playlists_path
    end 

    private 

    def set_playlist
        @playlist = Playlist.find_by(id: params[:id])
    end 

    # def redirect_if_not_owner
    #     if @playlist && @playlist.user != current_user
    #         flash[:alert] = "This is not your playlist!"
    #         redirect_to playlists_path 
    #     end 
    # end 

    def playlist_params 
        params.require(:playlist).permit(:name, :description, categories_attributes: [:name, :song_id], songs_attributes: [:title, :artist, :genre])
    end 

end
