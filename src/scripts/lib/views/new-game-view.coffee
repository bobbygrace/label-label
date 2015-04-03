$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, input, text, ul, li, h1, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
_ = require 'underscore'

SelectLabelsView = undefined
_.defer ->
  SelectLabelsView = require './select-labels-view.coffee'

template = renderable (data) ->
  h1 'Label Label'
  div '.js-fill-labels'

class NewGameView extends Backbone.View
  initialize: ->
    @labelView = new SelectLabelsView({ @model })

  render: ->
    @$el.append template()
    @fillSelectLabels()
    @

  fillSelectLabels: ->
    el = @labelView.render().el
    @$('.js-fill-labels').html el
    return

  remove: ->
    @labelView.remove()
    super

module.exports = NewGameView
