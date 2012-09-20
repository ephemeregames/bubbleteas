class BubbleTeaIngredient < ActiveRecord::Base

  belongs_to        :bubble_tea
  belongs_to        :ingredient
  attr_accessible   :ingredient_id
  #validates         :bubble_tea_id, presence: true # cannot validate when accept nested attributes of new record
  validates         :ingredient_id, presence: true, uniqueness: { scope: :bubble_tea_id }

end