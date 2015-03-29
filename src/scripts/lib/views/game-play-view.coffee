$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, h1, h2, h4, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
NewGameView = require './new-game-view.coffee'
Wordnik = require '../utils/wordnik.coffee'

gamePlayTemplate = renderable (data) ->
  h1 'Label Label'
  a '.js-new-game', href: "#", "Start a New Game"
  h2 '.js-fill-word'
  div '.definition.js-definition', ->
    a '.definition-show-button.js-get-definition', href: '#', 'Get definition.'
    p '.definition-text.js-fill-definition-text'
  div '.js-fill-label-select'
  div '.js-pair-list'

labelsTemplate = renderable (labels) ->
  h4 "This is…"
  ul ->
    for label in labels
      li ->
        a '.js-select-label', href: '#', 'data-labelname': label.name, label.name

pairsTemplate = renderable (pairs) ->
  for pair in pairs
    p ->
      strong pair.word
      text " is "
      strong pair.label
      text "."

class GamePlayView extends Backbone.View
  events:
    'click .js-new-game': 'newGame'
    'click .js-select-label': 'selectLabel'
    'click .js-get-definition': 'getDefinition'

  initialize: ->
    pairs = @getPairCollection()
    @listenTo pairs, 'add', @fillWord
    @listenTo pairs, 'add', @fillPairs

  getLabelCollection: ->
    @model.get('labelCollection')

  getPairCollection: ->
    @model.get('pairCollection')

  getLatestPair: ->
    @getPairCollection().last()

  getLatestWord: ->
    @getLatestPair()?.get('word')

  render: ->
    @$el.append gamePlayTemplate()
    @fillLabels()
    @getNewWord()
    @

  fillLabels: ->
    labels = @getLabelCollection().toJSON()
    @$('.js-fill-label-select').append labelsTemplate(labels)
    return

  fillWord: ->
    @hideDefinition()
    word = @getLatestWord()
    @$('.js-fill-word').text word
    return

  fillPairs: ->
    pairs = @getPairCollection().toJSON().reverse()

    data = []
    for pair in pairs
      if pair.label
        data.push pair

    @$('.js-pair-list').html pairsTemplate(data)
    return

  addWord: (word) ->
    @model.get('pairCollection').add
      word: word

  getNewWord: ->
    Wordnik.getRandomWords { limit: 1 }, (data) =>
      @addWord data[0].word

  getDefinition: ->
    Wordnik.getDefinition { word: @getLatestWord() }, (def) =>
      @showDefinition def

  showDefinition: (word) ->
    @$('.js-definition').addClass('is-shown')
    @$('.js-fill-definition-text').text word

  hideDefinition: ->
    @$('.js-definition').removeClass('is-shown')
    @$('.js-fill-definition-text').text ''

  selectLabel: (e) ->
    label = $(e.target).closest('a').attr('data-labelname')
    @getLatestPair().set 'label': label
    @getNewWord()
    return

  newGame: (e) ->
    e.preventDefault()
    game = AppView.startNewGame()

    view = new NewGameView({ model: game })
    AppView.showView view

    false

module.exports = GamePlayView
