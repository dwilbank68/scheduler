class UserMailer < ActionMailer::Base
  default from: "scheduler-wilbanks@herokuapp.com"

  # def send_email(user, msg)
  def send_email(user, email, msg)
    @user = user
    @msg = msg
    mail( :to => email, :subject => 'Hello from Scheduler' )
    # mail( :to => @user.email, :subject => 'Hello from Scheduler' ) if @user.contact_flags[3] == '1'
  end

end
