$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, text, ul, li, p, h1, strong, span, a, raw } = require 'teacup'
SelectLabelsView = require './select-labels-view.coffee'
Wordnik = require '../utils/wordnik.coffee'

template = renderable ->
  h1 ->
    span '.js-fill-first-word'
    text ' is '
    span '.js-fill-second-word'
  p ->
    strong 'Label Label'
    text ' is a game where you label words.'
  div '.js-game-view', 'LOADING'
  p 'Made by Bobby Grace.'

class LandingView extends Backbone.View
  initialize: ->
    @labelView = new SelectLabelsView({ @model })

  render: ->
    @$el.append template()
    @fillSelectLabels()
    @fillExampleWords()
    @

  fillExampleWords: ->
    Wordnik.getRandomWords { limit: 2 }, (data) =>
      @$('.js-fill-first-word').text data[0].word
      @$('.js-fill-second-word').text data[1].word

  fillSelectLabels: ->
    el = @labelView.render().el
    @$('.js-game-view').html el
    return

  remove: ->
    @labelView.remove()
    super

module.exports = LandingView
