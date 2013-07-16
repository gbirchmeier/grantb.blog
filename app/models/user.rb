class User < ActiveRecord::Base
#  attr_accessible :username,:email
#  attr_accessible :password, :password_confirmation

  default_scope order(:username)

  has_secure_password
  validates_presence_of :password, :on => :create

end

