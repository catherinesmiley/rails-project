class Song < ApplicationRecord
    has_many :categories
    has_many :playlists, through: :categories
end
