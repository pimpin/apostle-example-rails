class User < ActiveRecord::Base
  
  # Include devise modules.
  devise :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  after_create :send_confirmation_instructions # method given by devise.

end
