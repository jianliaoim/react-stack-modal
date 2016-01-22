
React = require 'react'

{div} = React.DOM

module.exports = React.createClass
  displayName: 'stack-overlay'

  propTypes:
    onClose: React.PropTypes.func.isRequired
    renderer: React.PropTypes.func.isRequired
    data: React.PropTypes.any.isRequired
    onContentClick: React.PropTypes.func.isRequired

  getName: ->
    @props.data.get?('name') or @props.data.name

  onClose: (event) ->
    @props.onClose event

  onClick: (event) ->
    @props.onContentClick @props.data, event
    event.stopPropagation()

  onBoxClick: (event) ->
    @props.onClose()

  render: ->
    name = @getName()

    div className: "stack-overlay as-#{name}", onClick: @onClick,
      div className: "stack-overlay-box", onClick: @onBoxClick,
        @props.renderer @props.data, @onClose
