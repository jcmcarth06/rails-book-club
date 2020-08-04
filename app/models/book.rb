class Book < ApplicationRecord
    belongs_to :user
    has_many :books_genres
    has_many :genres, through: :books_genres
    has_many :comments
    has_many :users, through: :comments
    
    validates :title, :author, :description, presence: true

    def self.alphabetize
        self.order(:title)
    end

    def self.search_for_books(search)
        if !search.blank?
            Book.where("title like ?", "%#{search}%" )
        else
            Book.all
        end
    end            
        
end