LabelCollection = require '../collections/label-collection.coffee'
WordCollection = require '../collections/word-collection.coffee'
PairCollection = require '../collections/pair-collection.coffee'
_ = require 'underscore'

class GameData
  constructor: ->
    @gameList = []
    @addNewGame()
    return

  addNewGame: ->
    labelCollection = new LabelCollection()
    wordCollection = new WordCollection()
    pairCollection = new PairCollection()

    labelCollection.add([
      { name: "Camping" }
      { name: "Punk Rock" }
      { name: "Internet Café" }
    ])

    newGame = {
      labelCollection
      wordCollection
      pairCollection
    }
      
    @gameList.push newGame

  getLatestGame: ->
    _.last @gameList
  
module.exports = GameData
