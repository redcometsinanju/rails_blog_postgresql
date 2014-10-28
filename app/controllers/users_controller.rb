class UsersController < ApplicationController

	def new
	end

	def create
		@user = User.new(user_params)
		if @user.save
      # Tell the UserMailer to send a welcome email after save
      # UserMailer.welcome_email(@user).deliver
			redirect_to posts_path
		else
			errors = ""
			@user.errors.each do |key, value|
				errors << "#{key}: #{value}"
			end
			redirect_to new_user_path, notice: errors
		end
	end

	# Finds the user depending on the :id of the user, from users/2, will return user 2
	# To set the user to only be the current user, @user = User.find(sessions[:current_user_id])
	def show
		@user = User.find(params[:id])
		# @current_user = User.find(sessions[:current_user_id])
	end

	def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to posts_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

	def destroy
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

end
