class UserMailer < ActionMailer::Base
  default from: "scheduler-wilbanks@herokuapp.com"

  def send_email(user, email, msg)
    @user = user
    @msg = msg
    mail( :to => email, :subject => 'Hello from Scheduler' )
  end

end
