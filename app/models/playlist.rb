class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories

    accepts_nested_attributes_for :songs

    validates :name, presence: true 
end
