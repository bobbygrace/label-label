$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
{ renderable, div, form, h1, h2, h4, input, text, ul, li, p, strong, span, a, raw } = require 'teacup'
AppView = require './app-view.coffee'
NewGameView = require './new-game-view.coffee'
Wordnik = require '../utils/wordnik.coffee'

gamePlayTemplate = renderable (data) ->

  div '.game-play-header', ->
    p '.u-quiet', ->
      text 'You’re playing Label Label. '
      a '.js-new-game', href: "#", "Start a new game."

  div '.word-section', ->
    h1 '.word-section-word.js-fill-word'
    div '.word-section-definition.js-definition', ->
      p '.word-section-definition-text.js-fill-definition-text', ' '

  div '.label-section.js-fill-label-select'

  div '.past-labeling-section', ->
    h4 'Past labeling…'
    div '.u-quiet.pair-list.js-pair-list'

labelsTemplate = renderable (labels) ->
  p ->
    strong "This is…"
  ul '.label-section-list', ->
    for label in labels
      li '.label-section-list-item', ->
        a '.label-section-list-item-button.js-select-label', href: '#', 'data-labelname': label.name, label.name

pairsTemplate = renderable (pairs) ->
  for pair in pairs
    p "#{pair.word} is #{pair.label}"

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

  getNewWord: ->
    Wordnik.getRandomWords { limit: 1 }, (data) =>
      word = data[0].word
      @addWord word
      @getDefinition word

  getDefinition: (word) ->
    if !word then word = @getLatestWord()
    Wordnik.getDefinition { word }, (def) =>
      @showDefinition def

  addWord: (word) ->
    @model.get('pairCollection').add
      word: word

  showDefinition: (def) ->
    @$('.js-fill-definition-text').text def

  hideDefinition: ->
    @$('.js-fill-definition-text').html '&nbsp;'

  selectLabel: (e) ->
    e.preventDefault()
    label = $(e.target).closest('a').attr('data-labelname')
    @getLatestPair().set 'label': label
    @getNewWord()
    false

  newGame: (e) ->
    e.preventDefault()
    game = AppView.startNewGame()

    view = new NewGameView({ model: game })
    AppView.showView view

    false

module.exports = GamePlayView
