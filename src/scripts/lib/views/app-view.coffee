$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, text, ul, li, p, strong, span, a, raw } = require 'teacup'
LandingView = require './landing-view.coffee'
GameView = require './game-view.coffee'
GameData = require '../data/game-data.coffee'

class AppView extends Backbone.View
  initialize: ->
    @gameData = new GameData()
    @showLandingView()

  showView: (view) ->
    if @currentView
      @currentView.remove()

    @currentView = view
    @currentView.render()

    $('.js-app-view').html @currentView.el

  showLandingView: ->
    view = new LandingView({ @gameData })
    @showView view
    return

  showGameView: ->
    view = new GameView({ @gameData })
    @showView view
    return

module.exports = AppView
