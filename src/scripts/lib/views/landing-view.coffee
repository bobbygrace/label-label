$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, text, ul, li, p, h1, strong, span, a, raw } = require 'teacup'
SelectLabelsView = require './select-labels-view.coffee'

template = renderable ->
  h1 'Coloring is Punk Rock'
  p 'Label Label is a game where you label words!'
  div '.js-game-view', 'LOADING'
  p 'Made by Bobby.'

class LandingView extends Backbone.View
  initialize: ->
    @labelView = new SelectLabelsView({ @model })

  render: ->
    @$el.append template()
    @fillSelectLabels()
    @

  fillSelectLabels: ->
    el = @labelView.render().el
    @$('.js-game-view').html el
    return

  remove: ->
    @labelView.remove()
    super

module.exports = LandingView
