class BooksController < ApplicationController
	def index
	  @books = Book.all #bookの一覧表示に使う
	  @book = Book.new #bookの新規投稿に使う
	  @username = current_user.name
      @userintroduction = current_user.introduction
	end

	def edit
	  @book = Book.find(params[:id])
	end

	def create #bookの投稿を保存
	  @book = Book.new(book_params)
	  @book.user_id = current_user.id
	  @book.save
	  redirect_to book_path(@book.id)
	end

    def show #bookの投稿の詳細を表示
      @book = Book.find_by(id: params[:id])
      @user = @book.user
      @username = current_user.name
      @userintroduction = current_user.introduction
    end

    def update
    	@book = Book.find(params[:id])
    	@book.update(book_params)
    	redirect_to book_path(@book.id)
    end

    def destroy
    	book = Book.find(params[:id])
    	book.destroy
    	redirect_to books_path
    end

    private
    def book_params
    	params.require(:book).permit(:title, :body, :user_id)
    end
end
