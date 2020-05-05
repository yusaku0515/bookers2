class UsersController < ApplicationController
  # アクセス制限（ユーザー編集）の為に追加
    before_action :authenticate_user!,{only:[:edit, :index, :show]} #authenticate_user! ー＞コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する


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
    if @user.id == current_user.id
       render "edit"
    else
       redirect_to user_path(current_user)
    end
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


  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
