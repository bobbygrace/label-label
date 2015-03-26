Backbone = require 'backbone'
LabelModel = require '../models/label-model.coffee'

class LabelCollection extends Backbone.Collection
  model: LabelModel

module.exports = LabelCollection
