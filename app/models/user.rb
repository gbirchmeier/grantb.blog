class User < ActiveRecord::Base
  has_many :posts, :inverse_of=>:user

  has_secure_password
  validates_presence_of :password, :on => :create

  def full_name
    "#{first_name} #{last_name}"
  end

end

