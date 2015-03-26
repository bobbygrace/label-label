Backbone = require 'backbone'
AppRouter = require '../lib/routers/app-router.coffee'
AppView = require '../lib/views/app-view.coffee'
GameCollection = require '../lib/collections/game-collection.coffee'

collection = new GameCollection()

options = {
  appView: new AppView({ collection })
}

router = new AppRouter(options)
Backbone.history.start({ pushState: true})
