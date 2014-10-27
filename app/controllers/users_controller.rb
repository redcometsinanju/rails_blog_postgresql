class UsersController < ApplicationController
	def new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to posts_path
		else
			redirect_to new_user_path
		end

	end

	def destroy
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

end