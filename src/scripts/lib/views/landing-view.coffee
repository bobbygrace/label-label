$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, text, ul, li, p, h1, strong, span, a, raw } = require 'teacup'
GameIntroView = require './game-intro-view.coffee'

template = renderable ->
  h1 'Coloring is Punk Rock'
  p 'Label Label is a game where you label words!'
  div '.js-game-view', 'LOADING'
  p 'Made by Bobby.'

class LandingView extends Backbone.View
  render: ->
    @$el.append template()
    @fillGameView()
    @

  fillGameView: ->
    gameView = new GameIntroView({ @model })
    gameView.render()
    @$('.js-game-view').html gameView.el
    return

module.exports = LandingView
