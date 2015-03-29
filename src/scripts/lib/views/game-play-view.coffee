$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
NewGameView = require './new-game-view.coffee'

template = renderable (data) ->
  p "GAME TIME"
  div '.js-fill-word'
  a '.js-new-game', href: "#", "New Game"
  div '.js-pair-list'

class GamePlayView extends Backbone.View
  events:
    'click .js-new-game': 'newGame'

  render: ->
    @$el.append template()
    @

  newGame: (e) ->
    e.preventDefault()
    game = AppView.startNewGame()

    view = new NewGameView({ model: game })
    AppView.showView view

    false

module.exports = GamePlayView
