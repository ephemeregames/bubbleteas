class @Application.Views.Admin extends Backbone.View

  el: '#content'


  initialize: =>
    # initialize content and sidebars
    this.$el.html(JST['layouts/admin']())

    # load ingredients and bubble teas
    ingredient_categories = new Application.Collections.IngredientCategories()
    bubble_teas = new Application.Collections.BubbleTeas()

    $.when(ingredient_categories.fetch(), bubble_teas.fetch()).then (results) =>
      new Application.Views.AdminIngredients(collection: ingredient_categories)
      new Application.Views.AdminBubbleTeas(collection: bubble_teas)
