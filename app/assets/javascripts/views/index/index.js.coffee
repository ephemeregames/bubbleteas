class @Application.Views.Index extends Backbone.View

  el: '#content'


  initialize: =>
    # initialize layout
    this.$el.html(JST['layouts/application']())

    # load categories and ingredients
    ingredient_categories = new Application.Collections.IngredientCategories()
    @bubble_teas = new Application.Collections.BubbleTeas()

    chef_choices = new Application.Collections.BubbleTeas()
    chef_choices.url = '/api/bubble_teas/chef_choices'

    top_bubble_teas = new Application.Collections.BubbleTeas()
    top_bubble_teas.url = '/api/bubble_teas/top'

    $.when(ingredient_categories.fetch(), @bubble_teas.fetch(), chef_choices.fetch(), top_bubble_teas.fetch()).then (results) =>
      selected_bubble_tea = @bubble_teas.get(this.options.bubble_tea_id)

      @content = new Application.Views.IndexContent(collection: ingredient_categories, bubble_teas: @bubble_teas, selected_bubble_tea: selected_bubble_tea)
      new Application.Views.IndexLeftSidebar(collection: ingredient_categories, chef_choices: chef_choices)
      new Application.Views.IndexRightSidebar(collection: @bubble_teas, top_bubble_teas: top_bubble_teas)


  showBubbleTea: (bubble_tea_id) =>
    bubble_tea = @bubble_teas.get(bubble_tea_id)

    @content.renderShowBubbleTea(bubble_tea)
