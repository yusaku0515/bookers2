class UserController < ApplicationController
	def index
	    @book = Book.all
	end
	def show
		@user = User.find(params[:id])
		@books = @user.books.page(params[:page]).revewse_order
	end
	def new
		@user_image = UserImage.new
	end
	def create
		@user_image = UserImage.new(user_image_params)
		@user_image.user_id = current_user.id
		@user_image.save
		redirect_to user_images_path
	end

	private
	def user_image_params
		params.require(:user_image).permit(:book_name, :image)
	end
end
