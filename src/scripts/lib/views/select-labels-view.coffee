$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
GamePlayView = require './game-play-view.coffee'
defaultLabels = require '../data/default-labels.coffee'
_ = require 'underscore'

template = renderable (data, labels) ->
  p 'Choose some labels…'

  ul '.js-labels', ->
    for l in labels
      li ->
        input '.js-label-value', value: l
    li ->
      input '.js-label-value'

  div ->
    a '.button.js-start-game', href: "#", "Start!"

newLabelTemplate = renderable ->
  li ->
    input '.js-label-value'


class SelectLabelsView extends Backbone.View
  events:
    'submit .js-submit-label-form': 'startGame'
    'click .js-start-game': 'startGame'
    'click .js-add-new-label': 'addNewLabel'
    'keyup .js-label-value': 'keyupLabelEvent'

  getRandomLabels: ->
    idx = _.random defaultLabels.length
    defaultLabels[idx]

  render: ->
    data = @model.toJSON()
    labels = @getRandomLabels()

    @$el.append template(data, labels)

    @

  addNewLabel: ->
    @$('.js-labels').append newLabelTemplate()

  keyupLabelEvent: (e) ->
    emptyInputs = []
    @$('.js-label-value').each ->
      if $(@).val() == ''
        emptyInputs.push(@)
      if emptyInputs.length > 1
        $(@).remove()

    if emptyInputs.length == 0
      @addNewLabel()

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
