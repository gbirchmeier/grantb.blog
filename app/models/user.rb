class User < ActiveRecord::Base
  has_many :posts, :inverse_of=>:user

#  attr_accessible :username,:email
#  attr_accessible :password, :password_confirmation

  default_scope { order(:username) }

  has_secure_password
  validates_presence_of :password, :on => :create

end

