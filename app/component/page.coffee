
React = require 'react'
shortid = require 'shortid'
Immutable = require 'immutable'

style = require '../style'

Devtools = React.createFactory require('actions-recorder/lib/devtools')
ModalStack = React.createFactory require '../../src/modal-stack'

div = React.createFactory 'div'

module.exports = React.createClass
  displayName: 'app-page'

  propTypes:
    dispatch: React.PropTypes.func.isRequired
    store: React.PropTypes.instanceOf(Immutable.Map).isRequired
    core: React.PropTypes.instanceOf(Immutable.Map).isRequired

  getInitialState: ->
    showDevTools: false
    path: Immutable.List()

  componentDidMount: ->
    window.addEventListener 'keydown', @onWindowKeydown

  componentWillUnmount: ->
    window.removeEventListener 'keydown', @onWindowKeydown

  onPathChange: (path) ->
    @setState path: path

  onModalA: (event) ->
    event.stopPropagation()
    @props.dispatch 'modal/add', name: 'a', id: shortid.generate()

  onModalB: (event) ->
    event.stopPropagation()
    @props.dispatch 'modal/add', name: 'b', id: shortid.generate()

  onPopoverA: (event) ->
    event.stopPropagation()
    @props.dispatch 'modal/add',
      name: 'a', id: shortid.generate(), type: 'popover'
      position:
        top: '40px'
        left: '40px'

  onModalClose: (modal) ->
    @props.dispatch 'modal/remove', modal.get('id')

  onModalEsc: (modals, event) ->
    if modals.size > 0
      @props.dispatch 'modal/remove', modals.last().get('id')

  onWindowClick: (modals, event) ->
    if modals.size > 0
      @props.dispatch 'modal/remove', modals.last().get('id')

  onWindowKeydown: (event) ->
    if event.metaKey and event.shiftKey and event.key is 'a'
      @setState showDevTools: (not @state.showDevTools)

  onDevToolsClick: (event) ->
    event.stopPropagation()

  onOverlayA: (event) ->
    event.stopPropagation()
    @props.dispatch 'modal/add', name: 'overlay a', id: shortid.generate(), type: 'overlay'

  renderControlPanel: ->
    div style: style.layout.panel,
      div style: style.widget.header, 'Modal buttons'
      div style: style.widget.button, onClick: @onModalA, 'Open modal A'
      div style: style.widget.button, onClick: @onModalB, 'Open modal B'
      div style: style.widget.header, 'Popover buttons'
      div style: style.widget.button, onClick: @onPopoverA, 'Open popover A'
      div style: style.widget.header, 'Overlay buttons'
      div style: style.widget.button, onClick: @onOverlayA, 'Open overlay A'

  renderModalContent: (data, onClose) ->
    switch data.get('name')
      when 'a'
        div {},
          'this is modal a, welcome!'
          @renderControlPanel()
          div onClick: onClose, 'demo'
      when 'b'
        div {},
          'inside modal B!'
          @renderControlPanel()
      when 'overlay a'
        @renderControlPanel()

  renderDevTools: ->
    div style: style.layout.container, onClick: @onDevToolsClick,
      Devtools
        core: @props.core
        language: 'en'
        width: window?.innerWidth or 1000
        height: window?.innerHeight or 400
        path: @state.path
        onPathChange: @onPathChange

  render: ->
    modals = @props.store.get 'modalStack'

    div className: 'app-page', style: style.layout.app,
      div null, 'Press `Command + Shift + A` to toggle debugger'
      @renderControlPanel()
      ModalStack
        renderer: @renderModalContent, modals: modals, onClose: @onModalClose
        onEsc: @onModalEsc, onWindowClick: @onWindowClick
      if @state.showDevTools
        @renderDevTools()
