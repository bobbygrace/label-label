$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
GamePlayView = require './game-play-view.coffee'
defaultLabels = require '../data/default-labels.coffee'
_ = require 'underscore'

template = renderable (data) ->
  p 'Choose some labels…'

  a '.js-get-new-labels', href: '#', ->
    text 'Get different labels…'

  ul '.js-label-list'

  div ->
    a '.button.js-start-game', href: "#", "Start!"

templateLabels = renderable (labels) ->
  for l in labels
    li ->
      input '.js-label-value', value: l
  li ->
    input '.js-label-value'


newLabelTemplate = renderable ->
  li ->
    input '.js-label-value'


class SelectLabelsView extends Backbone.View
  events:
    'click .js-get-new-labels': 'newLabelsEvent'
    'click .js-add-new-label': 'addNewLabel'
    'keyup .js-label-value': 'keyupLabelEvent'
    'submit .js-submit-label-form': 'startGame'
    'click .js-start-game': 'startGame'

  getRandomLabels: ->
    idx = _.random defaultLabels.length
    defaultLabels[idx]

  render: ->
    data = @model.toJSON()
    @$el.append template(data)
    @renderLabels()
    @

  renderLabels: ->
    labels = @getRandomLabels()
    @$('.js-label-list').empty().append templateLabels(labels)
    @

  newLabelsEvent: (e) ->
    e.preventDefault()
    @renderLabels()
    false

  addNewLabel: ->
    @$('.js-label-list').append newLabelTemplate()

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
