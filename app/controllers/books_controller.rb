class BooksController < ApplicationController
   before_action :authenticate_user!,{only:[:edit, :index, :show]} #ログインしていないと見れない　アクセス権限　表示させたくない物を選択する


	def index
	  @books = Book.all #bookの一覧表示に使う
	  @book = Book.new #bookの新規投稿に使う

	end

	def edit #他人が編集画面に行けないようにする
	       @book = Book.find(params[:id])
           if @book.user_id == current_user.id
           render "edit"
        else
           redirect_to books_path
        end
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
      @books = Book.find(params[:id])
      @user = @books.user
      @book_comment = BookComment.new
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

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    redirect_back(fallback_location: root_path)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    rredirect_back(fallback_location: root_path)
  end

    private
    def book_params
    	params.require(:book).permit(:title, :body, :user_id)
    end
end
