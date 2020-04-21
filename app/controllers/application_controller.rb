class ApplicationController < ActionController::Base
	before_action :authenticate_user! #ログイン認証されてないとログイン画面へリダイレクトする
	before_action :configure_permitted_parameters, if: :devise_controller?
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
	end
	def after_sign_in_path_for(resource)
		user_path(resource.id)
	end
end
