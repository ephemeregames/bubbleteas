class @Application.Views.AdminIngredient extends Backbone.View

  tagName: 'tr'
  className: 'ingredient'
  template: JST['admin/ingredient']


  events:
    'dblclick .name'        : 'editShow'
    'click .name .confirm'  : 'editConfirm'
    'keypress .name input'  : 'editConfirmOnEnter'
    'click .name .cancel'   : 'editCancel'
    'mouseover'             : 'showDelete'
    'mouseout'              : 'hideDelete'


  initialize: =>


  render: =>
    this.$el.html(this.template(this.model.toJSON()))

    @name        = this.$('.name .show')
    @edit        = this.$('.name .edit')
    @editInput   = this.$('.name .edit input')
    @color       = this.$('.color')
    @colorInput  = this.$('.color input')
    @deleteB     = this.$('.delete')

    @deleteB.clickover
      placement: 'right'
      trigger: 'click'
      delay: { show: 300, hide: 100 }
      title: 'Confirmation'
      content: JST['common/inplace_confirm']()
      onShown: => $('.confirm button').bind 'click', this.delete

    this.$('.colorify').miniColors(
      open: this.backupColor
      close: this.updateColor
    )


    @edit.hide()

    this


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


  backupColor: =>
    @colorBackup = @colorInput.val()


  updateColor: =>
    currentColor = @colorInput.val()

    return if currentColor == @backupColor

    this.model.save { color: currentColor }
      wait: true

      error: (model, response) =>
        $('#error_messages').html(JST['common/error_message']({
          type: 'Ingrédient',
          name: model.get('name'),
          errors: JSON.parse(response.responseText).errors
        }))

        @colorInput.val(@colorBackup)


  delete: =>
    this.model.destroy
      wait: true

      success: =>
        this.$el.hide()

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
