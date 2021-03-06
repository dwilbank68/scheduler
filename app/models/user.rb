class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :unit_users
  belongs_to :unit
  has_many :units, :through => :unit_users

  validates :name, :email, :presence => true

  validates :name,
            :length => { :minimum => 2, :maximum => 30 },
            :format => { :with => /\A[\w\s]+\z/ }

  validates :email,  :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :email2, :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, if: 'email2.present?'

  validates :name, :phone, :email,
            :uniqueness => true

  mount_uploader :avatar, AvatarUploader


  def send_sms(msg)
    twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
    twilio_token = ENV["TWILIO_AUTH_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    # @twilio_client.account.sms.messages.create( # deprecated
    @twilio_client.account.messages.create( :from => "+1#{twilio_phone_number}", :to => self.phone, :body => msg ) if self.contact_flags[5] == '1'
    @twilio_client.account.messages.create( :from => "+1#{twilio_phone_number}", :to => self.phone2, :body => msg ) if self.contact_flags[7] == '1'

  end

  # this overrides the current user's timezone until I get everything fixed to handle timezones
  def timezone
    "US/Pacific"
  end

  def formatted_email1
    if self.email && self.contact_flags[0] == "1"
      self.email.truncate(20)
    else
      "- - - - - - - - - - - - - - - -"
    end
  end

  def formatted_email2
    if self.email2 && self.contact_flags[2] == "1"
      self.email2.truncate(20)
    else
      "- - - - - - - - - - - - - - - -"
    end
  end

  def formatted_phone1
    if self.phone && self.contact_flags[4] == "1"
      digits = self.phone.gsub(/\D/, '')
      "#{digits[0]} (#{digits[1,3]}) #{digits[4,3]}-#{digits[7,4]}"
    else
      "- - - - - - - - - - - - - - - -"
    end
  end

  def formatted_phone2
    if self.phone2 && self.contact_flags[6] == "1"
      digits = self.phone2.gsub(/\D/, '')
      "#{digits[0]} (#{digits[1,3]}) #{digits[4,3]}-#{digits[7,4]}"
    else
      "- - - - - - - - - - - - - - - -"
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20],
           contact_flags: '00000000'
        )
    end
    user
  end

end

