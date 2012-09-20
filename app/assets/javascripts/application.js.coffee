#= require jquery
#= require jquery_ujs
#= require jquery.miniColors
#= require jquery.livequery
#= require twitter/bootstrap
#= require bootstrapx-clickover
#= require backbone-rails
#= require backbone-relational
#= require hamlcoffee
#= require i18n
#= require i18n/translations
#= require_tree ../templates

#= require ./backbone_application
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers
#= require_tree .


$(document).ready ->
  window.app = window.Application.initialize()
