AppView = require '../lib/views/app-view.coffee'
LandingView = require '../lib/views/landing-view.coffee'

game = AppView.startNewGame()
view = new LandingView({ model: game })

AppView.showView view
