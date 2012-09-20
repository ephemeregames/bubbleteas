class @Application.Views.AdminBubbleTea extends Backbone.View

  tagName: 'tr'
  className: 'bubble_tea'
  template: JST['admin/bubble_tea']


  events:
    'dblclick .name'        : 'editShow'
    'click .name .confirm'  : 'editConfirm'
    'keypress .name input'  : 'editConfirmOnEnter'
    'click .name .cancel'   : 'editCancel'
    'click .chef_choice'    : 'toggleChefChoice'
    'mouseover'             : 'showButtons'
    'mouseout'              : 'hideButtons'


  initialize: =>


  render: =>
    this.$el.html(this.template(this.model.toJSON()))

    @name        = this.$('.name .show')
    @edit        = this.$('.name .edit')
    @editInput   = this.$('.name .edit input')
    @deleteB     = this.$('.delete')
    @chefChoiceB = this.$('.chef_choice')

    @deleteB.clickover
      placement: 'right'
      trigger: 'click'
      delay: { show: 300, hide: 100 }
      title: 'Confirmation'
      content: JST['common/inplace_confirm']()
      onShown: => $('.confirm button').bind 'click', this.delete

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
            type: 'Bubble tea',
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
        this.$el.hide()

      error: (model, response) =>
        $('#error_messages').html(JST['common/error_message']({
          type: 'Bubble tea',
          name: model.get('name'),
          errors: JSON.parse(response.responseText).errors
        }))


  showButtons: =>
    @deleteB.removeClass('disabled')
    @chefChoiceB.removeClass('disabled')


  hideButtons: =>
    @deleteB.addClass('disabled')
    @chefChoiceB.addClass('disabled')


  toggleChefChoice: =>
    newState = !this.model.get('chef_choice')
    this.model.set(chef_choice: newState)

    this.model.save { chef_choice: newState }
      wait: true

      success: =>
        $('i', @chefChoiceB).toggleClass('icon-white', !newState)

      error: (model, response) =>
        $('#error_messages').html(JST['common/error_message']({
          type: 'Bubble tea',
          name: model.get('name'),
          errors: JSON.parse(response.responseText).errors
        }))
