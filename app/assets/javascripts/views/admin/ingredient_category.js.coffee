class @Application.Views.AdminIngredientCategory extends Backbone.View

  tagName: 'tr'
  className: 'ingredient_category'
  template: JST['admin/ingredient_category']

  events:
    'dblclick .name'       : 'editShow'
    'click .confirm_edit'  : 'editConfirm'
    'keypress .edit input' : 'editConfirmOnEnter'
    'click .cancel_edit'   : 'editCancel'
    'mouseover'            : 'showDelete'
    'mouseout'             : 'hideDelete'


  initialize: =>
    this.model.bind('add:ingredients', this.renderIngredient)


  render: =>
    this.$el.html(this.template(this.model.toJSON()))

    @name = this.$('.name')
    @edit = this.$('.edit')
    @editInput = this.$('.edit input')
    @deleteB = this.$('.delete')

    @deleteB.clickover
      position: 'right'
      trigger: 'click'
      delay: { show: 300, hide: 100 }
      title: 'Confirmation'
      content: JST['common/inplace_confirm']()
      onShown: => $('.confirm button').bind 'click', this.delete

    @edit.hide()

    this


  renderIngredient: (ingredient) =>
    view = new Application.Views.AdminIngredient({ model: ingredient })
    this.$el.nextAll('.add_ingredient').first().before(view.render().el)


  editShow: =>
    @name.hide()
    @edit.show()
    @editInput.val(this.model.get('name'))
    @editInput.focus()


  editConfirm: =>
    if @editInput.val() != @name.html()
      this.model.save { name: @editInput.val() }
        wait: true

        success: =>
          @name.html(@editInput.val())

        error: (model, response) =>
          $('#error_messages').html(JST['common/error_message']({
            type: 'Ingrédient',
            name: model.get('name'),
            errors: JSON.parse(response.responseText).errors
          }))

    @edit.hide()
    @name.show()


  editConfirmOnEnter: (event) =>
    this.editConfirm() if event.keyCode == 13


  editCancel: =>
    @edit.hide()
    @editInput.val(@name.html())
    @name.show()


  delete: =>
    this.model.destroy
      wait: true

      success: =>
        this.$el.nextUntil('.ingredient_category, .add_category').andSelf().hide()

      error: (model, response) =>
        $('#error_messages').html(JST['common/error_message']({
          type: 'Ingrédient',
          name: model.get('name'),
          errors: JSON.parse(response.responseText).errors
        }))


  showDelete: =>
    @deleteB.removeClass('disabled')


  hideDelete: =>
    @deleteB.addClass('disabled')
