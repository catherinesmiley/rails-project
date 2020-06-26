class SongsController < ApplicationController

    before_action :logged_in?, only: [:new, :edit, :destroy]
    before_action :find_playlist, only: [:show, :new]
    before_action :find_song, only: [:show, :update, :destroy]

    def show 
        redirect_if_not_song
    end 

    def index 
        @songs = Song.all.alphabetized
    end 

    def new 
        @song = Song.new 
        @song.categories.build if params[:playlist_id]
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
            redirect_if_not_playlist
            if @playlist && @playlist.user != current_user
                flash[:alert] = "You can't edit a song on another user's playlist!"
                redirect_to playlists_path 
            else 
                @song = @playlist.songs.find_by(id: params[:id])
                redirect_to playlist_songs_path(@playlist) if @song.nil?
            end
        else 
            find_song
            redirect_if_not_song
        end 
    end 

    def update 
        @song.update(song_params)
        if @song.save
            flash[:notice] = "Song updated."
            redirect_to song_path(@song) 
        else 
            render :edit
        end 
    end 

    def destroy 
        @song.categories.each(&:destroy)
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

    def find_song 
        @song = Song.find_by(id: params[:id])
    end 

    def redirect_if_not_song
        if !@song
            flash[:alert] = "This song does not exist!"
            redirect_to songs_path
        end 
    end 

    def song_params
        params.require(:song).permit(:title, :artist, :genre, categories_attributes: [:id, :name, :playlist_id])
    end 

end
