Backbone = require 'backbone'
WordModel = require '../models/word-model.coffee'

class WordCollection extends Backbone.Collection
  model: WordModel

module.exports = WordCollection
