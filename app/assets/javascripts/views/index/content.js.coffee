class @Application.Views.IndexContent extends Backbone.View

  el:                        '#index_content .content'
  template_welcome:          JST['index/welcome']
  template:                  JST['index/content']
  template_composition:      JST['index/composition']
  template_show_bubble_tea:  JST['index/show_bubble_tea']


  events:
    'mouseover .addBubbleTea'       : 'showAddBubbleTeaInput'
    'mouseout  .addBubbleTea'       : 'hideAddBubbleTeaInput'
    'click     .addBubbleTea input' : 'hideErrors'
    'click     .addBubbleTea .add'  : 'createBubbleTea'
    'keypress  .addBubbleTea input' : 'createBubbleTeaOnEnter'



  initialize: =>
    @templateSelected = 'welcome'
    @bubble_teas = this.options.bubble_teas
    @selected_bubble_tea = this.options.selected_bubble_tea
    @preview = new Wave()

    if @selected_bubble_tea
      this.renderShowBubbleTea(@selected_bubble_tea)
    else
      this.$el.html(this.template_welcome())

    this.$el.hide()
    this.$el.delay(150).fadeIn('fast')

    # Refresh the view if a ingredient is selected/deselected
    for category in this.collection.models
      category.get('ingredients').bind('change:selected', this.render)


  render: =>
    categoriesSelected = this.collection.selectedCategoriesCount()

    if categoriesSelected > 0 && @templateSelected == 'welcome'
      @templateSelected = 'content'

      this.$el.fadeOut 'fast', =>
        this.$el.html(this.template())
        this.renderComposition()
        this.renderNewBubbleTea()
        this.renderPreview()
        this.$el.fadeIn('fast')

      return

    if categoriesSelected <= 0
      @templateSelected = 'welcome'

      this.$el.fadeOut 'fast', =>
        this.$el.html(this.template_welcome())
        this.$el.fadeIn('fast')

      return

    this.renderComposition()
    this.renderNewBubbleTea()
    this.renderPreview()


  # refresh the composition of the bubble tea
  renderComposition: =>
    this.$('.composition').html(
      this.template_composition(
        ingredients: this.collection.selectedIngredients().map (ingredient) -> ingredient.toJSON()))


  renderNewBubbleTea: =>
    if this.collection.mixCompleted()
      this.$('.newBubbleTea').show()
      @addBubbleTea = this.$('.addBubbleTea')
    else
      this.$('.newBubbleTea').hide()


  renderShowBubbleTea: (bubble_tea) =>
    this.$el.html(this.template_show_bubble_tea(bubble_tea.toJSON()))
    this.renderPreview(bubble_tea)


  renderPreview: (bubble_tea) =>
    canvas = this.$('.preview canvas')

    canvas.attr('width', this.$('.preview').attr('width'))
    canvas.attr('height', this.$('.preview').attr('height'))

    if bubble_tea
      colors = bubble_tea.get('ingredients').map (ingredient) -> ingredient.get('color')
    else
      colors = this.collection.selectedIngredients().map (ingredient) -> ingredient.get('color')

    if colors.length == 1
      colors.push(colors[0])

    @preview.reset()
    @preview.initialize(canvas, colors[0], colors[1], colors[2])


  showAddBubbleTeaInput: =>
    $('input', @addBubbleTea).attr('disabled', false)
    $('button', @addBubbleTea).removeClass('disabled')


  hideAddBubbleTeaInput: =>
    $('input', @addBubbleTea).attr('disabled', true)
    $('button', @addBubbleTea).addClass('disabled')


  createBubbleTea: =>
    ingredients = this.collection.selectedIngredients()

    bubble_tea = new Application.Models.BubbleTea(
      name: this.$('.addBubbleTea input').val()
      ingredients: ingredients
    )

    bubble_tea.save {},
      wait: true

      success: =>
        @bubble_teas.add(bubble_tea)
        this.collection.resetSelectedIngredients()

      error: (model, response) =>
        $('input', @addBubbleTea).tooltip(
          html: true
          placement: 'bottom'
          trigger: 'manual'
          title: JST['common/inplace_error'](
            errors: JSON.parse(response.responseText).errors
          )
        ).tooltip('show')

        $(document).bind 'click', (event) =>
          $('input', @addBubbleTea).tooltip('destroy')


  hideErrors: =>
    $('input', @addBubbleTea).tooltip('hide')


  createBubbleTeaOnEnter: (event) =>
    this.createBubbleTea() if event.keyCode == 13
