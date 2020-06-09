class SongsController < ApplicationController

    def show 
        @song = Song.find_by(id: params[:id])
    end 

    def index 
        @songs = Song.all
    end 

    def new 
        @song = Song.new(song_params)
    end 

    private 

    def song_params
        params.require(:song).permit(:title, :artist, :genre)
    end 

end
