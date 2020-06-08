class SongsController < ApplicationController

    def show 
        @song = Song.find_by(id: params[:id])
    end 

    def index 
        @songs = Song.all
    end 

end
