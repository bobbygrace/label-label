$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
GamePlayView = require './game-play-view.coffee'

template = renderable ->
  p 'Choose some labels…'
  ul ->
    li 'camping'
    li 'punk rock'
    li 'internet cafe'
  input class: 'js-start-game', type: 'button', value: 'Start'

class GameIntroView extends Backbone.View
  initialize: ({@gameData}) ->
    @game = @gameData.getLatestGame()
    super

  events:
    'click .js-start-game': 'startGame'

  render: ->
    console.log @game
    @$el.append template()
    @

  startGame: ->
    @

module.exports = GameIntroView
