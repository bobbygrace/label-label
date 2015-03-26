$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'

template = renderable ->
  p ":)"

class GamePlayView extends Backbone.View
  initialize: ({@gameData}) ->
    @game = @gameData.getLatestGame()
    super

  render: ->
    @$el.append template()
    @

module.exports = GamePlayView
