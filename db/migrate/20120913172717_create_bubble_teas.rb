class CreateBubbleTeas < ActiveRecord::Migration
  def change

    create_table :ingredient_categories do |t|
      t.string :name
    end

    create_table :ingredients do |t|
      t.references :ingredient_category
      t.string :name
      t.string :color
      t.string :image
    end

    create_table :bubble_teas do |t|
      t.string :name
      t.boolean :chef_choice, default: false
    end

    create_table :bubble_tea_ingredients do |t|
      t.references :bubble_tea
      t.references :ingredient
    end

    create_table :user_bubble_teas do |t|
      t.references :user
      t.references :bubble_tea
      t.integer :rating
    end

  end
end
