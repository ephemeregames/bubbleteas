class @Application.Models.IngredientCategory extends Backbone.RelationalModel

  urlRoot: '/api/ingredient_categories'
  idAttribute: 'id'


  relations: [
    type: Backbone.HasMany
    key: 'ingredients'
    relatedModel: 'Application.Models.Ingredient'
    reverseRelation:
      key: 'category_id'
      includeInJSON: 'id'
  ]


Application.Models.IngredientCategory.setup()