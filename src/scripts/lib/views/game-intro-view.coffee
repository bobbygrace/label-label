$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
GamePlayView = require './game-play-view.coffee'

template = renderable (data) ->
  p 'Choose some labels…'
  ul ->
    for l in data.labels
      li l.name
  input class: 'js-start-game', type: 'button', value: 'Start'

class GameIntroView extends Backbone.View
  events:
    'click .js-start-game': 'startGame'

  render: ->
    data = {
      labels: @model.get('labelCollection').toJSON()
    }

    @$el.append template(data)

    @

  startGame: ->
    
    @

module.exports = GameIntroView
