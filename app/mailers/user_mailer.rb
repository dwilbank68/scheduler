class UserMailer < ActionMailer::Base
  default from: "scheduler-wilbanks@herokuapp.com"

  def send_email(user, msg)
    @user = user
    @msg = msg
    mail( :to => @user.email,
          :subject => 'Hello from Scheduler' )
  end

end
