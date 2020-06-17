class Playlist < ApplicationRecord
    belongs_to :user
    has_many :categories
    has_many :songs, through: :categories

    validates :name, presence: true 

    accepts_nested_attributes_for :songs, :categories

    # def categories_attributes=(category_attributes)
    #     category_attributes.each do |category_attribute|
    #         if category_attribute[:name].present? 
    #             category = Category.new(category_attribute)
    #             category.playlist = self 
    #             category.save
    #         end 
    #     end 
    # end 

    # def songs_attributes=(song_attributes)
    #     song_attributes.values.each do |song_attribute| 
    #         if song_attribute[:title].present?
    #             song = Song.find_or_create_by(song_attribute)
    #             # category = Category.find_or_create_by(song_attribute)
    #             if song.save
    #                 self.songs << song
    #                 # self.categories << category 
    #             end 
    #         end 
    #     end 
    # end 

end
