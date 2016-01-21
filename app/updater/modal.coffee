
schema = require '../schema'

exports.add = (store, data) ->
  store.update 'modalStack', (modalStack) ->
    newModal = schema.modal
    .set 'id', data.get('id')
    .set 'name', data.get('name')
    .set 'type', data.get('type')
    .set 'position', data.get('position')
    .set 'data', data.get('data')

    if (modalStack.size > 0) and modalStack.last().get('type') is 'popover'
      modalStack.butLast().push newModal
    else
      modalStack.push newModal

exports.remove = (store, data) ->
  store.update 'modalStack', (modalStack) ->
    index = modalStack.findIndex (modal) ->
      modal.get('id') is data
    modalStack.slice 0, index
