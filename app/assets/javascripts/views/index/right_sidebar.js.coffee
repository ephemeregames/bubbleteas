class @Application.Views.IndexRightSidebar extends Backbone.View

  el: '#right_sidebar'
  template: JST['index/right_sidebar']


  initialize: =>
    @top_bubble_teas = this.options.top_bubble_teas

    this.render()

    # Redraw the view when a bubble tea is added or removed
    this.collection.bind('add', this.render)
    this.collection.bind('remove', this.render)



  render: =>
    $(@el).html(this.template(bubble_teas: this.collection.toJSON(), top_bubble_teas: @top_bubble_teas.toJSON()))

    this.$el.hide()
    this.$el.delay(300).fadeIn('fast')

    this
