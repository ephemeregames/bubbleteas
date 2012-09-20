class User < ActiveRecord::Base

  has_many          :user_bubble_teas, dependent: :destroy
  has_many          :bubble_teas, through: :user_bubble_teas
  attr_accessible   :username, :password
  validates         :username, presence: true, uniqueness: true
  validates         :password, presence: true


  def self.authenticate(username, password)
    User.find_by_username_and_password(username, password)
  end

end