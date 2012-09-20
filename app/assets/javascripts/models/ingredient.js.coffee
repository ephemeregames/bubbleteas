class @Application.Models.Ingredient extends Backbone.RelationalModel

  urlRoot: '/api/ingredients'
  idAttribute: 'id'

  defaults:
    selected: false
    color: "#000000"

Application.Models.Ingredient.setup()
