class UsersController < ApplicationController
  def index
  	@users = User.all
    @book = Book.new
    @username = current_user.name
    @userintroduction = current_user.introduction
  end

  def show
    @book = Book.new
    @books = Book.all
    @username = current_user.name
    @userintroduction = current_user.introduction
    @user = User.find_by(id: params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
