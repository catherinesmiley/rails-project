class User < ApplicationRecord
    has_many :playlists
    has_many :songs, through: :playlists

    has_secure_password 

    validates :username, presence: true, uniqueness: true 
    validates :password, presence: true 

    def playlist_count 
        self.playlists.length
    end 
end
