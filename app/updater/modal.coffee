
schema = require '../schema'

exports.add = (store, data) ->
  store.update 'modalStack', (modalStack) ->
    newModal = schema.modal
    .set 'id', data.get('id')
    .set 'name', data.get('name')
    .set 'type', data.get('type')
    .set 'position', data.get('position')
    .set 'data', data.get('data')
    modalStack.push newModal

exports.remove = (store, data) ->
  store.update 'modalStack', (modalStack) ->
    modalStack.filterNot (modal) ->
      modal.get('id') is data
