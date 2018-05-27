module ApplicationHelper
	def current_user
		if cookies[:uid]
		User.find_by(id: cookies[:uid])
		end
	end
end
