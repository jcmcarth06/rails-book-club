class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    before_action :redirect_if_not_user, only: [:edit, :update, :destroy]
    
    def index
        @books = Book.search_for_books(params[:title]).alphabetize
    end

    def new
        @book = Book.new
    end

    def create
        @book = current_user.books.build(book_params)
        if @book.valid?
            @book.save
            redirect_to book_path(@book)
        else
            @book = Book.find_by_id(params[:book_id]) if params[:book_id]
            render :new
        end
    end

    def edit
    end

    def update
        if @book.update(book_params)
            redirect_to book_path(@book)
        else
            render :edit
        end
    end

    def show
    end

    def destroy
        @book.destroy
        redirect_to books_path
    end

private

    def find_book
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:author, :title, :description, genre_ids:[])
    end

    def redirect_if_not_user
        if @book.user != current_user
            flash[:error] = "Sorry! You do not have permission to edit or delete this book. Here are your books:"  
            redirect_to user_path(current_user)
        end
    end

end
