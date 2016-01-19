
React = require 'react'
recorder = require 'actions-recorder'

schema = require './schema'
updater = require './updater'

require('volubile-ui/ui/index.less')
require('./main.css')

recorder.setup
  initial: schema.store
  updater: updater
  inProduction: false

render = ->
  Page = React.createFactory require './component/page'
  React.render Page(dispatch: recorder.dispatch, store: recorder.getStore(), core: recorder.getCore()),
    document.querySelector('.demo')

render()
recorder.subscribe render

if module.hot
  module.hot.accept ['./component/page'], ->
    render()
  module.hot.accept ['./updater'], ->
    updater = require './updater'
    recorder.hotSetup
      initial: schema.store
      updater: updater
