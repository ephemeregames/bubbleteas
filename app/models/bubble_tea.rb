class BubbleTea < ActiveRecord::Base

  has_many                        :ingredients, class_name: 'BubbleTeaIngredient', dependent: :destroy
  accepts_nested_attributes_for   :ingredients
  attr_accessible                 :ingredients_attributes, :name, :chef_choice
  has_many                        :user_bubble_teas, dependent: :destroy
  has_many                        :users, through: :user_bubble_teas
  validates                       :name, length: { minimum: 1, maximum: 20 }, uniqueness: true
  validate                        :check_if_unique, if: :new_record?


  def as_json(options = {})
    {
      id: self.id,
      name: self.name,
      chef_choice: self.chef_choice,
      ingredients: self.ingredients.map(&:ingredient)
    }
  end


  protected

    def check_if_unique

      others = BubbleTeaIngredient.
        select('bubble_tea_id, count(*) AS matching_ingredients').
        where("ingredient_id IN (#{self.ingredients.map(&:ingredient_id).join(',')})").
        group('bubble_tea_id').having("matching_ingredients >= #{self.ingredients.size}").all

      if others.size > 0
        errors.add(:bubble_tea, I18n.t('activerecord.errors.messages.already_exists'))
      end


    end

end