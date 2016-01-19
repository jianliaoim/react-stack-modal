
React = require 'react'
shortid = require 'shortid'
Immutable = require 'immutable'

style = require '../style'

ModalStack = React.createFactory require '../../src/modal-stack'

div = React.createFactory 'div'

module.exports = React.createClass
  displayName: 'app-page'

  propTypes:
    dispatch: React.PropTypes.func.isRequired
    store: React.PropTypes.instanceOf(Immutable.Map).isRequired

  onModalA: ->
    @props.dispatch 'modal/add', name: 'a', id: shortid.generate()

  onModalB: ->
    @props.dispatch 'modal/add', name: 'b', id: shortid.generate()

  onModalClose: (modal) ->
    @props.dispatch 'modal/remove', modal.get('id')

  onModalEsc: (modals, event) ->
    if modals.size > 0
      @props.dispatch 'modal/remove', modals.last().get('id')

  renderControlPanel: ->
    div {},
      div style: style.widget.button, onClick: @onModalA, 'Open modal A'
      div style: style.widget.button, onClick: @onModalB, 'Open modal B'

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

  render: ->
    modals = @props.store.get 'modalStack'

    div className: 'app-page',
      @renderControlPanel()
      ModalStack renderer: @renderModalContent, modals: modals, onClose: @onModalClose, onEsc: @onModalEsc
