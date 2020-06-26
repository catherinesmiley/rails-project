module SongsHelper

    def song_path_helper(playlist, song)
        if playlist 
            edit_playlist_song_path(playlist, song)
        else 
            edit_song_path(song)
        end 
    end 

end
