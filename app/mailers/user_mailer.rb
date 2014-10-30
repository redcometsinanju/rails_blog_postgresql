class UserMailer < ActionMailer::Base
  default from: "welcome@moodly.com"

  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.username} <#{@user.email}>"
    @url  = 'https://moodly-app.herokuapp.com/users/new'
    mail(to: email_with_name, subject: 'Welcome to Moodly!')
  end
end
'http://example.com/login'