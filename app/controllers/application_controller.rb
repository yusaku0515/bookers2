class ApplicationController < ActionController::Base
	 #ログイン認証されてないとログイン画面へリダイレクトする
	before_action :configure_permitted_parameters, if: :devise_controller?
	def after_sign_up_path_for(resource)
		user_path(resource) #root_pathでも可
	end
	def after_sign_in_path_for(resource)
		user_path(resource)
	end


	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
	end

	def login_required #非ログインユーザーへの機能制限（見れなくする） books_controllerにも記載あり
		redirect_to login_path unless current_user
	end
end
