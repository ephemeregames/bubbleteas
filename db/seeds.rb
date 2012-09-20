# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts 'Seeding ingredient categories.'
YAML.load_file("#{Rails.root}/db/fixtures/categories.yml").each do |category|
  IngredientCategory.create!(category)
end

puts 'Seeding ingredients.'
YAML.load_file("#{Rails.root}/db/fixtures/ingredients.yml").each do |ingredient|
  Ingredient.create!(ingredient)
end
