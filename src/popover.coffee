
React = require 'react'

{div} = React.DOM

module.exports = React.createClass
  displayName: 'stack-popover'

  propTypes:
    onClose: React.PropTypes.func.isRequired
    renderer: React.PropTypes.func.isRequired
    data: React.PropTypes.any.isRequired

  getName: ->
    @props.data.get?('name') or @props.data.name

  getStyle: ->
    position = @props.data.get('position')
    position.toJS?() or position

  onClose: (event) ->
    @props.onClose event

  onClick: (event) ->
    event.stopPropagation()

  render: ->
    name = @getName()

    div className: "stack-popover as-#{name}", onClick: @onClick, style: @getStyle(),
      @props.renderer @props.data, @onClose
