class @Application.Routers.Application extends Backbone.Router

  routes:
    ''                : 'index'
    'admin'           : 'admin'
    'bubble_tea/:id'  : 'bubble_tea'


  index: =>
    @headerView = new window.Application.Views.Header(initial: 'index')
    @indexView = new window.Application.Views.Index()

    $('#content').hide()
    $('#content').delay(50).fadeIn('fast')


  admin: =>
    @headerView = new window.Application.Views.Header(initial: 'admin')
    @adminView = new window.Application.Views.Admin()

    $('#content').hide()
    $('#content').delay(50).fadeIn('fast')


  bubble_tea: (id) =>
    if @indexView
      @indexView.showBubbleTea(id)
    else
      @headerView = new window.Application.Views.Header(initial: 'index')
      @indexView = new window.Application.Views.Index(bubble_tea_id: id)

      $('#content').hide()
      $('#content').delay(50).fadeIn('fast')
