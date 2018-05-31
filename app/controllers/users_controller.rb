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
			return redirect_to :back
		end
		# redirect_to root_path
	end

	def sign_out
		# @user = User.find(current_user.id)
		cookies.delete :uid
		# respond_to do |format|
	 #        format.html
	 #    end
	 return redirect_to root_path
	 #    respond_to do |format|
		#   format.js {render inline: "location.reload();" }
		# end

		# redirect_to root_path
	end

	# def redirect
	# 	respond_to do |format|
	#         format.js
	#     end
	# end

	def google_callback
		@user_info = request.env['omniauth.auth']
		@user = User.new
		@user.name = @user_info['info']['name']
		@user.picture = "https://robohash.org/#{@user.name}"
		@user.password = '123'
		@user.save 
	 # skandknk 
		redirect_to root_path
	end

	def user_list
		@list = List.where('user_id = ?', current_user.id)
		p @list
	end
end
