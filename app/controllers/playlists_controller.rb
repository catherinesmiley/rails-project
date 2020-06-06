class PlaylistsController < ApplicationController

    def new 
        @playlist = Playlist.new
    end

    private 

    def playlist_params 
        params.require(:playlist).permit(:name, :description)
    end 

end
