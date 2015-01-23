class UserMailer < ActionMailer::Base
  default from: "scheduler-wilbanks@herokuapp.com"

  def send_email(user, msg)
    @user = user
    @msg = msg
    mail( :to => @user.email,
          :subject => 'Thanks for signing up for our amazing app' )
  end

end
