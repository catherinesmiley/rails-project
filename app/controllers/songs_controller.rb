class SongsController < ApplicationController

    def show 
        @song = Song.find_by(id: params[:id])
    end 

    def index 
        @songs = Song.all
    end 

    def new 
        @song = Song.new 
        playlist = Playlist.find_by(id: params[:playlist_id])
        @song.playlists << playlist
        # method to call @playlist.id
        # either don't allow non-nested route for songs new or add validation here
    end 

    def create
        byebug
    end 

    private 

    def song_params
        params.require(:song).permit(:title, :artist, :genre, playlist_ids: [])
    end 

end
