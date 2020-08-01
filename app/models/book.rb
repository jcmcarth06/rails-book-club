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

    def self.search(search)
        if search
            book_name = Book.find_by(name: search)
            if book_name
                self.where(book_id: book_name)
            else
                @books = Book.all
            end
        else
            @books = Book.all
        end
    end            
        
end