class Song < ApplicationRecord
    has_many :categories
    has_many :playlists, through: :categories

    validates :title, presence: true

    scope :alphabetized, -> { order(title: :asc) }

    # def category_names=(names)
    #     # self.categories = Category.find_or_create_by(name: name)
    #     Category.all.each do |category|
    #         if names.include?(category)
    #             self.categories << category 
    #         end 
    #     end 
    # end 

    # def category_names
    #     self.categories ? self.categories.names : nil 
    # end 

    def categories_attributes=(category_attributes)
        category_attributes.values.each do |category_attribute| 
            if category_attribute[:name].present?
                category = Category.find_or_create_by(category_attribute)
                if category.save
                    self.categories << category
                end 
            end 
        end 
    end 

    def category_name=(name)
        new_category = Category.find_or_create_by(name: name)
        self.categories << new_category
    end 

    def category_name
        self.categories ? self.categories.name : nil
    end 
end
