class UserImagesController < ApplicationController
	def new
		@user_image = UserImage.new
	end
	def index
		@user_image = UserImage.all
	end
	def show
		@user_image = UserImage.find(params[:id])
	end
	def create
		@user_image = UserImage.new(user_image_params)
		@user_image.user_id = current_user.id
		@user_image.save
		redirect_to user_images_path
	end
	private
    def post_image_params
        params.require(:post_image).permit(:image, :caption)
    end
end
