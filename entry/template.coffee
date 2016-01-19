
stir = require 'stir-template'
React = require 'react'
config = require 'config'
recorder = require 'actions-recorder'

schema = require '../app/schema'
updater = require '../app/updater'

assetLinks = require '../packing/asset-links'

Page = React.createFactory require '../app/component/page'

{html, head, title, body, meta, script, link, div, a, span} = stir

recorder.setup
  initial: schema.store
  updater: updater
  inProduction: false

module.exports = (data) ->

  stir.render stir.doctype(),
    html null,
      head null,
        title null, "React Stack Modal"
        meta charset: 'utf-8'
        link rel: 'icon', href: 'http://tp4.sinaimg.cn/5592259015/180/5725970590/1'
        if assetLinks.style?
          link rel: 'stylesheet', href: assetLinks.style
        script src: assetLinks.vendor, defer: true
        script src: assetLinks.main, defer: true
      body null,
        div class: 'intro',
          div class: 'title', "This is a demo of Stack Modal."
          div class: 'line', "Click the buttons to try"
          div null,
            span null, "Read more at "
            a href: 'http://github.com/jianliaoim/react-stack-modal',
              'github.com/jianliaoim/react-stack-modal'
            span null, '.'
        div class: 'demo',
          React.renderToString Page(dispatch: recorder.dispatch, store: recorder.getStore(), core: recorder.getCore())
