class Song < ApplicationRecord
    has_many :categories
    has_many :playlists, through: :categories

    validates :title, presence: true 

    scope :alphabetized, -> { order(title: :asc) }
end
