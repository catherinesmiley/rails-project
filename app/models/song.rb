class Song < ApplicationRecord
    has_many :categories
    has_many :playlists, through: :categories

    validates :title, presence: true

    scope :alphabetized, -> { order(title: :asc) }

    accepts_nested_attributes_for :categories

    def self.search(input)
        Song.where("title LIKE ?", "%#{input}%")
    end

end
