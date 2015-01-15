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
            # :length => { in: 2..30 },
            :format => { :with => /\A[\w\s]+\z/ }

  validates :email,
            :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}

  validates :name, :phone, :email,
            :uniqueness => true

  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,# :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # phony_normalize :phone, :default_country_code => 'US'
  # phony_normalize :phone2, :default_country_code => 'US'

  mount_uploader :avatar, AvatarUploader



  def timezone
    "US/Pacific"
  end

end

