
Immutable = require 'immutable'

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

clearPopoverAfter = (acc, modalStack, id, isFound) ->
  if modalStack.size is 0
    acc
  else
    cursor = modalStack.first()
    if isFound
      if cursor.get('type') is 'popover'
        clearPopoverAfter acc, modalStack.rest(), id, true
      else
        clearPopoverAfter acc.push(cursor), modalStack.rest(), id, true
    else
      if cursor.get('id') is id
        clearPopoverAfter acc.push(cursor), modalStack.rest(), id, true
      else
        clearPopoverAfter acc.push(cursor), modalStack.rest(), id, false

exports.contentClick = (store, id) ->
  store.update 'modalStack', (modalStack) ->
    clearPopoverAfter Immutable.List(), modalStack, id, false
