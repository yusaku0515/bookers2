class UsersController < ApplicationController
  # アクセス制限（ユーザー編集）の為に追加
    before_action :authenticate_user!,{only:[:edit, :index, :show]} #authenticate_user! ー＞コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する
    before_action :ensure_correct_user,{only:[:edit]}

    def ensure_correct_user
        if current_user.id != params[:id].to_i
           redirect_to book_path(@book.id)
        end
    end

  def index
  	@users = User.all
    @book = Book.new
    @user = User.find_by(id: params[:id])
  end

  def show
    @book = Book.new
    @books = Book.where(user_id: params[:id])
    @user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if	@user.update(user_params)
        flash[:notice] = "You have updated user successfully."
    	  redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
