class SongsController < ApplicationController

    def show 
        @song = Song.find_by(id: params[:id])
    end 

    def index 
        if params[:playlist_id]
            @songs = Playlist.find(params[:playlist_id]).songs 
        else 
            @songs = Song.all 
        end 
    end 

end
