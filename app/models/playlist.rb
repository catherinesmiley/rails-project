class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories

    validates :name, presence: true 

    def categories_attributes=(category_attributes)
        category_attributes.values.each do |category_attribute|
            if category_attribute[:name].present? && category_attribute[:song_id].present?
                category = Category.new(category_attribute)
                self.categories << category
            end 
        end 
    end 

    def songs_attributes=(song_attributes)
        song_attributes.values.each do |song_attribute| 
            if song_attribute[:title].present?
                Song.find_by(title: song_attribute[:title]) || Song.create(song_attribute)
            end 
        end 
    end 

end
