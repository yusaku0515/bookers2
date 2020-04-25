class BooksController < ApplicationController


	def index
	  @books = Book.all #bookの一覧表示に使う
	  @book = Book.new #bookの新規投稿に使う
	  @user = User.find_by(id: params[:id])
	end

	def edit
	  @book = Book.find(params[:id])
	end

	def create #bookの投稿を保存
	     @book = Book.new(book_params)
	     @book.user_id = current_user.id
	  if @book.save
	     redirect_to book_path(@book.id), notice: "You have creatad book successfully."
	  else
	  	 @books = Book.all
	     render "index"
	  end
	end

    def show #bookの投稿の詳細を表示
      @book = Book.new
      @books = Book.find_by(id: params[:id])
      @username = current_user.name
      @user = User.find_by(id: params[:id])
    end

    def update
    	@book = Book.find(params[:id])
    	if @book.update(book_params)
    	   flash[:notice] = "You have updated book successfully."
    	   redirect_to book_path(@book.id)
    	else
    	  render "edit"
    	end
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
