class UserController < ApplicationController
	def show
		@user = User.find(params[:id])
		@books = @user.books.page(params[:page]).revewse_order
	end
end
