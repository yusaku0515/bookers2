class UsersController < ApplicationController
  def index
  	@user = User.all
  end
  def show
  	@user = User.find(params[:id])
  end
  def edit
  	@user = User.find(params[:id])
  end
  def create
  	@user = User.new(user_params)
  	@user.save
  	redirect_to user_path(@user.id)
  end
  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end
  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :title, :opinion)
  end
end
