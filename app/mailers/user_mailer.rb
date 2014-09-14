class UserMailer < ActionMailer::Base
  default from: "saas@ceg.co.in"

  def signup_confirmation(user)
  	@user = user
  	mail to: @user.email, subject: 'confirmation from ceg.co.in!'
  end
end
