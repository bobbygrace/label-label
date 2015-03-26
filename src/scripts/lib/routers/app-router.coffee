$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
LandingView = require '../views/landing-view.coffee'
GameView = require '../views/game-view.coffee'

class AppRouter extends Backbone.Router
  routes:
    "": "showLandingView"
    "game/:id": "showGameView"

  initialize: (options) ->
    @appView = options.appView

  showLandingView: ->
    game = @appView.collection.startGame()
    view = new LandingView({ model: game })
    @appView.showView view
    return

  showGameView: (id) ->
    game = @appView.collection.get(id)
    if !game
      game = @appView.collection.startGame()
    view = new GameView({ model: game })
    @appView.showView view
    return

module.exports = AppRouter
