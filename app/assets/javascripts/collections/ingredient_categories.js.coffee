class @Application.Collections.IngredientCategories extends Backbone.Collection

  model: Application.Models.IngredientCategory
  url: '/api/ingredient_categories'


  # funny piece of code to count the number of selected category of ingredients
  selectedCategoriesCount: =>
    (((
      this.models.map (category) ->
        category.get('ingredients').map (ingredient) ->
          ingredient.get('selected')
    ).reduce (c1, c2) -> c1.concat(c2)
    ).map (value) -> if value then 1 else 0
    ).reduce (v1, v2) -> v1 + v2


  selectedIngredients: =>
    (this.models.map (category) ->
      category.get('ingredients').filter (ingredient) ->
        ingredient.get('selected')
    ).reduce (c1, c2) -> c1.concat(c2)


  resetSelectedIngredients: =>
    for ingredient in this.selectedIngredients()
      ingredient.set(selected: false)


  # A mix is completed when we chose at least one ingredient per category
  mixCompleted: =>
    this.selectedIngredients().length >= this.models.length


  # Create a random mix
  randomMix: =>
    this.resetSelectedIngredients()

    for category in this.models
      ingredientsCount = category.get('ingredients').length
      continue if ingredientsCount == 0

      randomIndex = Math.floor(Math.random() * (ingredientsCount))

      category.get('ingredients').at(randomIndex).set(selected: true)
