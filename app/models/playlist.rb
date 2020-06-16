class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories

    validates :name, presence: true 

    # accepts_nested_attributes_for :songs
    # create custom songs_attributes=
    # if song does not save, do nothing
    # if it does, shovel into playlist (self.songs)

    def songs_attributes=(song_attributes)
        song_attributes.values.each do |song_attribute| 
            if song_attribute[:title].present?
                song = Song.find_or_create_by(song_attribute)
                if song.save
                    self.songs << song
                end 
            end 
        end 
    end 

end
