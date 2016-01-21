
React = require 'react'

Modal = React.createFactory require './modal'
Popover = React.createFactory require './popover'
Overlay = React.createFactory require './overlay'
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
    window.addEventListener 'click', @onWindowClick

  componentWillUnmount: ->
    window.removeEventListener 'keydown', @onWindowKeydown
    window.removeEventListener 'click', @onWindowClick

  getType: (modal) ->
    modal.get?('type') or modal.type or 'modal'

  onClose: (modal) ->
    @props.onClose modal

  onClick: (event) ->
    event.stopPropagation()

  onWindowKeydown: (event) ->
    if (event.keyCode is 27)
      @props.onEsc @props.modals, event

  onWindowClick: (event) ->
    @props.onWindowClick @props.modals, event

  render: ->
    div className: 'modal-stack', onClick: @onClick,
      Transition
        transitionName: 'stack'
        enterTimeout: @props.timeout
        leaveTimeout: @props.timeout
        @props.modals.map (modal, index) =>
          onClose = => @onClose modal
          switch @getType(modal)
            when 'modal'
              Modal data: modal, onClose: onClose, renderer: @props.renderer, key: index
            when 'popover'
              Popover data: modal, onClose: onClose, renderer: @props.renderer, key: index
            when 'overlay'
              Overlay data: modal, onClose: onClose, renderer: @props.renderer, key: index
