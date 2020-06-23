class SongsController < ApplicationController

    before_action :logged_in?, only: [:new, :edit, :destroy]
    before_action :find_playlist, only: [:show, :new]

    def show 
        # find_playlist
        @song = Song.find_by(id: params[:id])
        if !@song 
            flash[:alert] = "That song does not exist!"
            redirect_to songs_path
        end 
    end 

    def index 
        @songs = Song.all.alphabetized
    end 

    def new 
        # find_playlist
        @song = Song.new 
        @song.categories.build
        render :new
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
            @playlist = Playlist.find_by(id: params[:playlist_id])
            if @playlist.nil? || @playlist.user != current_user
                redirect_to playlists_path 
            else 
                @song = playlist.songs.find_by(id: params[:id])
                redirect_to playlist_songs_path(playlist) if @song.nil?
            end
        else 
            @song = Song.find_by(id: params[:id]) 
            if !@song
                flash[:alert] = "This song does not exist!"
                redirect_to songs_path
            end 
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

    def destroy 
        @song = Song.find(params[:id])
        @song.destroy
        flash[:notice] = "Song deleted."
        redirect_to songs_path
    end 

    private 

    def find_playlist 
        if params[:playlist_id]
            @playlist = Playlist.find_by(id: params[:playlist_id])
        end 
    end 

    def song_params
        params.require(:song).permit(:title, :artist, :genre, :category_name, categories_attributes: [:name, :playlist_id])
    end 

end
