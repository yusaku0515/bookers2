class SearchsController < ApplicationController
  def search
  	method = params[:search_method]
  	word = params[:search_word]
  	@users = User.search(method,word)
  	if params[:name].present?
  		@user = @user.got_by_name params[:name]
  	end
  end
end
