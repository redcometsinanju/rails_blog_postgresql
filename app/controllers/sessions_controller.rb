class SessionsController < ApplicationController

	def create
		@user = User.find_by(:email => params[:email])
		if @user.nil?
			flash[:error] = "No such user"
		elsif @user.authenticate(params[:password])
			session[:current_user_id] = @user.id
			# flash[:notice] = "Welcome #{@user.username}"
		else
			flash[:error] = "Incorrect password"
		end
		redirect_to posts_path
	end

	def destroy
		session[:current_user_id] = nil
		flash[:notice] = "You are logged out"
		redirect_to root_path
	end
end




# Colt
# colt@ga.co
# id: 2

# session{
# 	current_user_id: 2
# }