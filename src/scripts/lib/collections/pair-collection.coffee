Backbone = require 'backbone'
PairModel = require '../models/pair-model.coffee'

class PairCollection extends Backbone.Collection
  model: PairModel

module.exports = PairCollection
