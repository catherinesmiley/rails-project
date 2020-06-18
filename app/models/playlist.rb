class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories

    validates :name, presence: true 

    accepts_nested_attributes_for :songs, :categories

end
