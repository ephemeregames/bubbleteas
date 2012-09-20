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

      # oh my god.
      others = BubbleTea.includes(:ingredients).all.map{ |bt| bt.ingredients.map(&:ingredient_id) }
      composition = self.ingredients.map(&:ingredient_id)

      others.reject!{ |o| o != composition }

      unless others.empty?
        errors.add(:bubble_tea, I18n.t('activerecord.errors.messages.already_exists'))
      end


    end

end