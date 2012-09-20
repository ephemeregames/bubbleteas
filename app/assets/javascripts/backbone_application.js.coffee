class @Application

  @Models      : { }
  @Collections : { }
  @Views       : { }
  @Routers     : { }

  @initialize: =>
    @mainRouter = new Application.Routers.Application()

    Backbone.history.start()

    applicationView = new Application.Views.MainApplication()
