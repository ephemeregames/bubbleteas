class @Application.Views.AdminIngredients extends Backbone.View

  el: '#ingredients'
  template: JST['admin/ingredients']

  events:
    'click     .add_category button'   : 'addCategory'
    'keypress  .add_category input'    : 'addCategoryOnEnter'
    'mouseover .add_category'          : 'showAdd'
    'mouseout  .add_category'          : 'hideAdd'

    'click     .add_ingredient button' : 'addIngredient'
    'keypress  .add_ingredient input'  : 'addIngredientOnEnter'
    'mouseover .add_ingredient'        : 'showAdd'
    'mouseout  .add_ingredient'        : 'hideAdd'


  initialize: =>
    # Fetch and render the categories with the ingredients layout
    this.$el.html(this.template())

    @categories = this.$('.categories')

    this.collection.bind('add', this.renderCategory)

    this.collection.each (category) =>
      view = new Application.Views.AdminIngredientCategory(model: category)
      @categories.append(view.render().el)

      category.get('ingredients').each (ingredient) =>
        @categories.append(new Application.Views.AdminIngredient(model: ingredient).render().el)

      @categories.append(JST['admin/add_ingredient']({ category_id: category.id }))

    @categories.append(JST['admin/add_ingredient_category']())

    this.$('.add_ingredient .colorify').miniColors()


  renderCategory: (category) =>
    view = new Application.Views.AdminIngredientCategory(model: category)
    $('tr', @categories).last().before(view.render().el)
    $('tr', @categories).last().before(JST['admin/add_ingredient']({ category_id: category.id }))
    $('.colorify', $('tr', @categories).last().prev()).miniColors()


  addCategory: (event) =>
    newCategory = new Application.Models.IngredientCategory({ name: this.$('.add_category input').val() })
    newCategory.save {},
      success: =>
        this.collection.add(newCategory)

        this.$('.add_category input').val('')

      error: (model, response) =>
        $('#error_messages').html(JST['common/error_message']({
          type: 'Catégorie',
          name: model.get('name'),
          errors: JSON.parse(response.responseText).errors
        }))


  addCategoryOnEnter: (event) =>
    this.addCategory(event) if event.keyCode == 13


  addIngredient: (event) =>
    scope = $(event.currentTarget).closest('.add_ingredient')

    category_id = scope.data('category_id')
    name        = $('.name input', scope)
    color       = $('.color input', scope)

    newIngredient = new Application.Models.Ingredient
      ingredient_category_id  : category_id
      name                    : name.val()
      color                   : color.val()

    newIngredient.save {},
      success: =>
        this.collection.get(category_id).get('ingredients').add(newIngredient)

        name.val('')
        color.val('#000')

      error: (model, response) =>
        $('#error_messages').html(JST['common/error_message']({
          type: 'Ingrédient',
          name: model.get('name'),
          errors: JSON.parse(response.responseText).errors
        }))


  addIngredientOnEnter: (event) =>
    this.addIngredient(event) if event.keyCode == 13


  showAdd: (event) =>
    $('.add', event.currentTarget ? event).removeClass('disabled')
    $('input', event.currentTarget ? event).attr('disabled', false)


  hideAdd: (event) =>
    $('.add', event.currentTarget ? event).addClass('disabled')
    $('input', event.currentTarget ? event).attr('disabled', true)
