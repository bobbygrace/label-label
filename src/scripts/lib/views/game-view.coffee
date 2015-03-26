$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, h1, p, strong, span, a, raw } = require 'teacup'
GameIntroView = require './game-intro-view.coffee'

template = renderable ->
  h1 'Label Label'
  a class: 'js-start-new-game', href: '#', 'Start a new game.'
  p 'footer...'

class GameView extends Backbone.View
  render: ->
    @$el.append template()
    @

module.exports = GameView
