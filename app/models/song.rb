class Song < ApplicationRecord
    has_many :categories
    has_many :playlists, through: :categories

    validates :title, presence: true

    scope :alphabetized, -> { order(title: :asc) }

    accepts_nested_attributes_for :categories

    # def categories_attributes=(category_attributes)
    #     category = Category.create(category_attributes["0"])
    #     if category.name
    #         category.song = self 
    #         category.save
    #     end 
    # end 

    # def category_name=(name)
    #     new_category = Category.create(name: name, song: self)
    #     # self.categories << new_category
    #     self.save
    # end 

    # def category_name
    #     # self.categories ? self.categories.name : nil
    # end 
end
