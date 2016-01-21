
Immutable = require 'immutable'

exports.store = Immutable.fromJS
  modalStack: []

exports.modal = Immutable.fromJS
  id: null
  name: null
  data: {}
  type: null
