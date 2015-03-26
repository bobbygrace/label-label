Backbone = require 'backbone'
GameModel = require '../models/game-model.coffee'
LabelCollection = require '../collections/label-collection.coffee'
WordCollection = require '../collections/word-collection.coffee'
PairCollection = require '../collections/pair-collection.coffee'

class GameCollection extends Backbone.Collection
  model: GameModel

  startGame: ->
    labelCollection = new LabelCollection()
    wordCollection = new WordCollection()
    pairCollection = new PairCollection()

    labelCollection.add([
      { name: "Camping" }
      { name: "Punk Rock" }
      { name: "Internet Café" }
    ])

    @add {
      labelCollection: labelCollection
      wordCollection: wordCollection
      pairCollection: pairCollection
    }

module.exports = GameCollection
