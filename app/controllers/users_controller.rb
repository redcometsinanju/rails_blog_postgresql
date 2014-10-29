class UsersController < ApplicationController

  def index
  	@allusers = User.all
    @users = []
    if params[:search] == ''
      @users = User.all
    elsif !params[:search].nil?
      search = params[:search].downcase
      @users = User.where("lower(username) like ?", "%#{search}%")
    end
    
    sent = current_user.invites_sent
    sent_to = sent.map {|friend| User.find(friend.guest_id)}
    received = current_user.invites_received
    received_from = received.map {|friend| User.find(friend.host_id)}
    
    @friends = sent_to + received_from
    @not_friends = @allusers - @friends
    
    render :index
  end

  def invite
  	# binding.pry
  	current_user.invites_sent.push(ChatInvite.new(guest: User.find(params[:guest_id])))
  	redirect_to posts_path
  end

	def new
	end

	def create
		@user = User.new(user_params)

		if @user.save
      # Tell the UserMailer to send a welcome email after save
      # UserMailer.welcome_email(@user).deliver
      domain = 'sandboxab13a54924b44d0185046d49a35a2640.mailgun.org'
      api_key = 'key-0664c48b5f3a9476227dc0f6f48c3191'

      username = 'api'
      password = api_key
      url = "https://api.mailgun.net/v2/#{domain}/messages"

      params = {
          :from => "Mailgun Sandbox <postmaster@moodly.com>",
          :to => "#{@user.email}",
          :subject => "Welcome to Moodly #{@user.username}",
          :html => "<h3>You have successfully signed up to Moodly.com</h3>
          - Massively Open Online Discussion board -
          <br>
          ==============================================
          <br>
          <br>
          Your username is #{@user.username}. 
          <br>
          <br>
          To login to the site, click <a href='http://localhost:3000'>here</a>.
          <br>
          <br>
          Thanks for joining!"
      }

      options = {
          method: :post,
          params: params,
          userpwd: "#{username}:#{password}"
      }

      trequest = Typhoeus::Request.new(url, options)
      tresponse = trequest.run()

			redirect_to posts_path, notice: 'Sign up successful. Please sign in.'
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
		params.require(:user).permit(:username, :email, :password, :password_confirmation, :image)
	end

end
