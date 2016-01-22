
hsl = require 'hsl'

exports.button =
  backgroundColor: hsl 0, 90, 80
  color: 'white'
  display: 'inline-block'
  padding: '0 15px'
  marginRight: 10
  borderRadius: 15
  lineHeight: '30px'
  cursor: 'pointer'

exports.header =
  fontWeight: 'bold'
  fontSize: '24px'
  marginTop: 40
  marginBottom: 20
