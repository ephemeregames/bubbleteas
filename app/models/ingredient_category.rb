class IngredientCategory < ActiveRecord::Base

  has_many          :ingredients, dependent: :destroy
  validates         :name, presence: true, uniqueness: true
  attr_accessible   :name


  def as_json(options = {})
    {
      id: self.id,
      name: self.name,
      ingredients: self.ingredients
    }
  end

end
