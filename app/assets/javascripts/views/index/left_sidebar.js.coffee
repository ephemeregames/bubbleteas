class @Application.Views.IndexLeftSidebar extends Backbone.View

  el: '#left_sidebar'
  template: JST['index/left_sidebar']


  events:
    'click .generator .reset'   : 'resetGenerator'
    'click .generator .shuffle' : 'shuffleGenerator'


  initialize: =>
    @chef_choices = this.options.chef_choices

    this.render()

    # Recalculate the progress bar when a model is selected/deselected
    for category in this.collection.models
      category.get('ingredients').bind('change:selected', this.syncProgressBar)


  render: =>
    this.$el.html(this.template(categories: this.collection.toJSON(), chef_choices: @chef_choices.toJSON()))

    @progressBar = this.$('.progress .bar')

    this.collection.each (category) =>
      view = new Application.Views.IndexIngredientCategory(model: category)
      this.$('.generator .content .categories').append(view.render().el)

    this.$el.hide()
    this.$el.fadeIn('fast')

    this


  syncProgressBar: =>
    categoriesCount = this.collection.models.length

    selectedCount = this.collection.selectedCategoriesCount()

    if categoriesCount == 0
      @progressBar.css('width', '0%')
    else
      progress = ((selectedCount / categoriesCount) * 100) | 0
      @progressBar.css('width', progress + '%')


  resetGenerator: =>
    this.collection.resetSelectedIngredients()


  shuffleGenerator: =>
    this.collection.randomMix()
