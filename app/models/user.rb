class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :unit_users
  belongs_to :unit
  has_many :units, :through => :unit_users

  validates :name, :email, :presence => true

  validates :name,
            :length => { :minimum => 2, :maximum => 30 },
            :format => { :with => /\A[\w\s]+\z/ }

  validates :email, :email2,
            :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}

  validates :name, :phone, :email,
            :uniqueness => true

  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,# :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader

  def send_sms(msg)
    twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
    twilio_token = ENV["TWILIO_AUTH_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    # @twilio_client.account.sms.messages.create( # deprecated
    @twilio_client.account.messages.create( :from => "+1#{twilio_phone_number}", :to => self.phone, :body => msg ) if self.contact_flags[5] == '1'
    @twilio_client.account.messages.create( :from => "+1#{twilio_phone_number}", :to => self.phone2, :body => msg ) if self.contact_flags[7] == '1'
    # puts "-twilio-"*20
    # puts "#{msg} was sent"
    # puts "-twilio-"*20
  end

  # this overrides the current user's timezone until I get everything fixed to handle timezones
  def timezone
    "US/Pacific"
  end

end

