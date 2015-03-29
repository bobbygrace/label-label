$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
GamePlayView = require './game-play-view.coffee'

template = renderable (data) ->
  p 'Choose some labels…'
  ul ->
    li ->
      input '.js-label-value', value: "Camping"
    li ->
      input '.js-label-value', value: "Punk Rock"
    li ->
      input '.js-label-value', value: "Internet Café"
  a href: "#",  class: 'js-start-game', "Start!"

class SelectLabelsView extends Backbone.View
  events:
    'submit .js-submit-label-form': 'startGame'
    'click .js-start-game': 'startGame'

  render: ->
    data = @model.toJSON()

    @$el.append template(data)

    @

  startGame: (e) ->
    e.preventDefault()

    addToLabelCollection = (value) =>
      if value != ''
        @model.get('labelCollection').add
          'name': value

    @$('.js-label-value').each ->
      addToLabelCollection $(@).val()

    view = new GamePlayView({ @model })
    AppView.showView view

    false

module.exports = SelectLabelsView
