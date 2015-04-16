$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, hr, text, ul, li, p, h1, strong, span, a, raw } = require 'teacup'
SelectLabelsView = require './select-labels-view.coffee'
Wordnik = require '../utils/wordnik.coffee'

template = renderable ->

  div '.landing-header', ->
    h1 ->
      span '.js-fill-first-word'
      text ' is '
      span '.js-fill-second-word'

  div '.landing-intro', ->
    p ->
      text 'This is '
      strong 'Label Party'
      text ', a game where you label words.'
    p ->
      text 'You’ll get a random word courtesy of '
      a href: 'https://www.wordnik.com/', 'Wordnik'
      text ' then you’ll give it a label. Label Party is best played in groups where you can debate and justify your answers.'

  div '.js-game-view', 'Loading…'

  div '.landing-footer.u-quiet', ->
    p ->
      text 'Made by '
      a href: 'http://bobbygrace.info/', 'Bobby Grace'
      text '. Words courtesy of '
      a href: 'https://www.wordnik.com/', 'Wordnik'
      text '. Conceived and often played at '
      a href: 'https://trello.com/', 'Trello'
      text '.'

class LandingView extends Backbone.View
  initialize: ->
    @labelView = new SelectLabelsView({ @model })

  className: "landing"

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
