class UsersController < ApplicationController
	def sign_in
	end

	def authenticate
		@user = User.find_by(name: params[:name],password: params[:password])
		p params
		if @user == nil
			flash[:danger] = "Wrong Credential"
			return redirect_back fallback_location: root_path
		else
			flash[:primary] = "Welcome #{@user.name}"
			cookies[:uid] = @user.id
			return redirect_to root_path
		end
	end

	def sign_up	
	end

	def create
		@user = User.new
		@user.name = params[:name]
		@user.picture = "https://robohash.org/#{@user.name}"
		@user.password = params[:password]
		if @user.save
			flash[:success] = "Successfully create #{@user.name}. Please Log in using name and password"
			redirect_to root_path
		else
			flash[:danger] = "Please Change Your Name"
			return redirect_to :back
		end
		# redirect_to root_path
	end

	def sign_out
		cookies.delete :uid
		redirect_to root_path
	end

	def google_callback
		@user_info = request.env['omniauth.auth']
		@user = User.new
		@user.name = @user_info['info']['name']
		@user.password = '123'
		@user.save 
		redirect_to root_path
	end

	def user_list
		@list = List.where('user_id = ?', current_user.id)
		p @list
	end
end
