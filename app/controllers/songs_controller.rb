class SongsController < ApplicationController

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
        # @song.categories.last.playlist_id = params[:song][:playlist_ids][0]
        if @song.save 
            redirect_to song_path(@song)
        else
            render :new 
        end 
    end 

    private 

    def song_params
        params.require(:song).permit(:title, :artist, :genre, :category_name, categories_attributes: [:name, :playlist_id])
    end 

end
