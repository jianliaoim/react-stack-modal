
React = require 'react'

{div} = React.DOM

module.exports = React.createClass
  displayName: 'stack-modal'

  propTypes:
    onClose: React.PropTypes.func.isRequired
    renderer: React.PropTypes.func.isRequired
    data: React.PropTypes.any.isRequired

  getName: ->
    @props.data.get?('name') or @props.data.name

  onClose: (event) ->
    @props.onClose event

  onBoxClick: (event) ->
    event.stopPropagation()

  render: ->
    name = @getName()

    div className: "stack-modal as-#{name}", onClick: @onClose,
      div className: 'stack-modal-box', onClick: @onBoxClick,
        @props.renderer @props.data, @onClose
