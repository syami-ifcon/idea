class UsersController < ApplicationController
	def sign_in
	end

	def authenticate
		@user = User.find_by(name: params[:name],password: params[:password])
		if @user == nil
			flash[:danger] = "Wrong Credential"
			return redirect_back fallback_location: root_path
		else
			cookies[:uid] = @user.id
			redirect_to root_path
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
			return redirect_to sign_up_path 
		end
		# redirect_to root_path
	end

	def sign_out
	 cookies.delete :uid
	 flash[:danger] = "Please Refresh the page"
	 return redirect_to root_path
	end

	# def redirect
	# 	respond_to do |format|
	#         format.js
	#     end
	# end

	def google_callback
		@user_info = request.env['omniauth.auth']
		x = User.find_by(name: @user_info['info']['name'])
		if x == nil
			@user = User.new
			@user.name = @user_info['info']['name']
			@user.picture = "https://robohash.org/#{@user.name}"
			@user.password = '123'
			@user.save
			cookies[:uid] = @user.id
			# flash[:success] = "Please Login using #{@user.name} and password '123'"
		else
		    cookies.delete :uid
			cookies[:uid] = x.id
			# flash[:success] = "Please Login using #{@x.name} and password #{@x.password}"
		end

		redirect_to root_path
	end

	def user_list
		@list = List.where('user_id = ?', current_user.id)
		p @list
	end
end
