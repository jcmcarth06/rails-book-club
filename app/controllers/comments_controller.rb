class CommentsController < ApplicationController
    before_action :find_comment, :redirect_if_not_user, only: [:show, :edit, :update, :destroy]
    
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
        @comment = @book.comments.create(comment_params)
        @comment.user.id = current_user.id
        if @comment.save
            redirect_to book_path(@book)
        else
            redirect_to book_path(book)
        end
    end

    def show
        @book = Book.find(params[:id])
      end

    def edit
        @comment = Comment.find_by(id: params[:id])
    end

    def update
        @comment = Comment.find_by(id: params[:id])
        if @comment.user == current_user
            @book.comment.update(comment_params)
            redirect_to comment_path(@comment)
        else
            render :edit
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        if @comment.user.id == current_user.id 
            @comment.destroy 
        else 
            redirect_to books_path 
        end
    end

private

    def find_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:content, :book_id)
    end

end
