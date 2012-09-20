class @Application.Views.IndexIngredientCategory extends Backbone.View

  tagName: 'div'
  className: 'ingredient_category'
  template: JST['index/ingredient_category']

  events:
    'click .ingredient'    : 'toggleIngredient'


  initialize: =>

    # when an ingredient's selected change, we synchronize it's visual representation
    this.model.get('ingredients').bind 'change:selected', (resource) =>
      this.$(".ingredient[id=#{resource.id}]").toggleClass('active', resource.get('selected'))


  render: =>
    this.$el.html(this.template(category: this.model.toJSON()))
    this


  toggleIngredient: (event) =>
    button = $(event.currentTarget)

    other_buttons = button.siblings().not('.disabled')

    for b in other_buttons
      this.model.get('ingredients').get(b.id).set(selected: false)

    this.model.get('ingredients').get(button.attr('id')).set(selected: !button.hasClass('active'))
