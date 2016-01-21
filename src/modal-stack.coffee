
React = require 'react'

Modal = React.createFactory require './modal'
Transition = React.createFactory require './transition'

{div} = React.DOM

module.exports = React.createClass
  displayName: 'modal-stack'

  propTypes:
    modals: React.PropTypes.any.isRequired
    renderer: React.PropTypes.func.isRequired
    onClose: React.PropTypes.func.isRequired
    onEsc: React.PropTypes.func
    timeout: React.PropTypes.number

  getDefaultProps: ->
    timeout: 500
    onEsc: ->

  componentDidMount: ->
    window.addEventListener 'keydown', @onWindowKeydown

  componentWillUnmount: ->
    window.removeEventListener 'keydown', @onWindowKeydown

  onClose: (modal) ->
    @props.onClose modal

  onClick: (event) ->
    event.stopPropagation()

  onWindowKeydown: (event) ->
    if (event.keyCode is 27)
      @props.onEsc @props.modals, event

  render: ->
    div className: 'modal-stack', onClick: @onClick,
      Transition
        transitionName: 'stack-modal'
        enterTimeout: @props.timeout
        leaveTimeout: @props.timeout
        @props.modals.map (modal, index) =>
          onClose = => @onClose modal
          Modal data: modal, onClose: onClose, renderer: @props.renderer, key: index
