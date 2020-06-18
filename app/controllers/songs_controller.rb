class SongsController < ApplicationController

    before_action :logged_in?, only: [:edit]
    before_action :redirect_if_not_current_user, only: [:edit]

    def show 
        @song = Song.find_by(id: params[:id])
        if params[:playlist_id]
            playlist = Playlist.find_by(id: params[:playlist_id])
        end
    end 

    def index 
        @songs = Song.all.alphabetized
    end 

    def new 
        @song = Song.new 
        @song.categories.build
        if params[:playlist_id]
            @playlist = Playlist.find_by(id: params[:playlist_id])
        else 
            render :new
        end 
        # method to call @playlist.id
    end 

    def create
        @song = Song.new(song_params) 
        if @song.save 
            redirect_to song_path(@song)
        else
            render :new 
        end 
    end 

    def edit 
        if params[:playlist_id]
            playlist = Playlist.find_by(id: params[:playlist_id])
            if playlist.nil? || !current_user
                redirect_to playlists_path 
            else 
                @song = playlist.songs.find_by(id: params[:id])
                redirect_to playlist_songs_path(playlist) if @song.nil? || !current_user
            end
        else 
            @song = Song.find(params[:id]) unless !current_user
        end 
    end 

    def update 
        @song = Song.find(params[:id])
        @song.update(song_params)
        if @song.save
            redirect_to song_path(@song)
        else 
            render :edit
        end 
    end 

    private 

    def song_params
        params.require(:song).permit(:title, :artist, :genre, :category_name, categories_attributes: [:name, :playlist_id])
    end 

end
