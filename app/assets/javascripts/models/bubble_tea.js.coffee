class @Application.Models.BubbleTea extends Backbone.RelationalModel

  urlRoot: '/api/bubble_teas'
  idAttribute: 'id'

  relations: [
    type: Backbone.HasMany
    key: 'ingredients'
    relatedModel: 'Application.Models.Ingredient'
  ]


#  parse: (response) =>
#    console.log response


#  toPersistentJSON: =>
#    ingredients = this.get('ingredients').map (ingredient) -> ingredient.id
#
#    {
#      id: this.id
#      name: this.get('name')
#      ingredients: ingredients
#    }


Application.Models.BubbleTea.setup()
