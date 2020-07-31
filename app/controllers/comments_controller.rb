class CommentsController < ApplicationController
    before_action :find_comment, only: [:show, :edit, :update, :destroy]

    def index
        @user = User.find_by(id: params[:user_id])
        if @user 
            @comments = @user.comments
        else 
            @comments = Comment.all
        end 
    end

    def new
        @comment = Comment.new(book_id: params[:book_id])
    end

    def create
        @book = Book.find(params[:book_id])
        @comment = @book.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to book_path(@book)
        else 
            redirect_to books_path(book)
        end
    end

    def show
        @comment  = Comment.find(params[:id])
    end

    def edit
    end

    def update
        if @comment.user == current_user
            @comment.update(comment_params)
            redirect_to book_path(@comment.book_id)
        else 
            render :edit 
        end

    end

    def destroy
        if @comment.user == current_user
            @comment.destroy 
            redirect_to book_path(@comment.book_id)

        else
            redirect_to books_path 
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :book_id, user_attributes: [:name])
    end

    def find_comment
        @comment = Comment.find(params[:id])
    end
end