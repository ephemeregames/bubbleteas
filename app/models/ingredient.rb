class Ingredient < ActiveRecord::Base

  belongs_to        :category, class_name: 'IngredientCategory', foreign_key: 'ingredient_category_id'
  attr_accessible   :ingredient_category_id, :name, :color, :image
  validates         :ingredient_category_id, presence: true
  validates         :name, presence: true, uniqueness: { scope: :ingredient_category_id }
  validates         :color, presence: true
  #validates         :image, presence: true


  def as_json(options = {})
    {
      id: self.id,
      name: self.name,
      color: self.color,
      image: self.image,
      category_id: self.category.id
    }
  end

end
