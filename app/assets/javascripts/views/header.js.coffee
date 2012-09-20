class @Application.Views.Header extends Backbone.View

  el: '#header'

# For linkable routes, we prefer to initialize the header on URL change
#  events:
#    'click .admin': 'toggleAdmin'
#    'click .index': 'toggleIndex'


  initialize: =>
    $(@el).html(JST['header']())

    @index = this.$('.index').parent()
    @admin = this.$('.admin').parent()

    if this.options.initial == 'index'
      this.toggleIndex()
    else
      this.toggleAdmin()


  toggleAdmin: =>
    @index.removeClass('active')
    @admin.addClass('active')


  toggleIndex: =>
    @index.addClass('active')
    @admin.removeClass('active')
