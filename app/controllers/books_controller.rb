class BooksController < ApplicationController
	def index
	  @book = Book.all
	end

	def new
	end

	def create #bookの投稿を保存
	  @book = Book.new(book_params)
	  @book.save
	  rederect_to books_path(@book.id)
	end

    def show #bookの投稿の詳細を表示
      @book = Book.find(params[:id])
    end

    private
    def book_params
    	params.require(:book).permit(:title, :body)
    end
end
