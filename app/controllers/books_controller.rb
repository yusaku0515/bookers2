class BooksController < ApplicationController
	def new
	end
	def create #bookの投稿を保存
	  @book = Book.new(book_params)
	  @book.save
	  rederect_to books_path(@book.id)
	end
	def index
	  @book = Book.all
	  @books = Book.new
	end
    def show #bookの投稿の詳細を表示
    end

    private
    def book_params
    	params.require(:book).permit(:title, :opinion)
    end
end
