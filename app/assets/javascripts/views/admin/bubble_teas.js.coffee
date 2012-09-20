class @Application.Views.AdminBubbleTeas extends Backbone.View

  el: '#bubble_teas'
  template: JST['admin/bubble_teas']


  initialize: =>
    this.render()

    @bubble_teas = this.$('.bubble_teas')

    this.collection.each (bubble_tea) =>
      view = new Application.Views.AdminBubbleTea(model: bubble_tea)
      @bubble_teas.append(view.render().el)


  render: =>
    $(@el).html(this.template())
    this
