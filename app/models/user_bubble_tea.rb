class UserBubbleTea < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :bubble_tea
  validates   :user_id, presence: true
  validates   :bubble_tea_id, presence: true, uniqueness: { scope: :user_id }

end
