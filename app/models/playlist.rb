class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories
end
