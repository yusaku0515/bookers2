class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
    @book = Book.new
    @user = User.find_by(id: params[:id])
  end

  def show
    @book = Book.new
    @books = Book.where(user_id: params[:id])
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
