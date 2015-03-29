Backbone = require 'backbone'
GameModel = require '../models/game-model.coffee'
LabelCollection = require '../collections/label-collection.coffee'
PairCollection = require '../collections/pair-collection.coffee'

class GameCollection extends Backbone.Collection
  model: GameModel

  startGame: ->

    @add {
      labelCollection: new LabelCollection()
      pairCollection: new PairCollection()
    }

module.exports = GameCollection
