`import Em from 'ember'`

UsersController = Em.Controller.extend
  list: Em.computed.filterBy('content', 'isNew', false)

`export default UsersController`
