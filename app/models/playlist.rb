class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories

    validates :name, presence: true 

    def songs_attributes=(song_attributes)
        song_attributes.values.each do |song_attribute| 
            if song_attribute[:title].present?
                song = Song.find_or_create_by(song_attribute)
                # category = Category.find_or_create_by(song_attribute)
                if song.save
                    self.songs << song
                    # self.categories << category 
                end 
            end 
        end 
    end 

end
