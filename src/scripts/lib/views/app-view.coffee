$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
GameCollection = require '../collections/game-collection.coffee'

module.exports = new class AppView

  constructor: ->
    @collection = new GameCollection()

  startNewGame: ->
    @collection.startGame()

  getLatestGame: ->
    @collection.last()

  showView: (view) ->

    if @currentView
      @currentView.remove()

    @currentView = view
    el = @currentView.render().el

    $('.js-app-view').empty().append el
