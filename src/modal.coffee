
React = require 'react'

{div} = React.DOM

module.exports = React.createClass
  displayName: 'stack-modal'

  propTypes:
    onClose: React.PropTypes.func.isRequired
    renderer: React.PropTypes.func.isRequired
    data: React.PropTypes.any.isRequired

  onClose: (event) ->
    @props.onClose event

  onBoxClick: (event) ->
    event.stopPropagation()

  render: ->
    div className: 'stack-modal', onClick: @onClose,
      div className: 'stack-modal-box', onClick: @onBoxClick,
        @props.renderer @props.data, @onClose
