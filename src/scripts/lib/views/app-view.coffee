$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

class AppView extends Backbone.View

  showView: (view) ->
    if @currentView
      @currentView.remove()

    @currentView = view
    @currentView.render()

    $('.js-app-view').html @currentView.el

module.exports = AppView
