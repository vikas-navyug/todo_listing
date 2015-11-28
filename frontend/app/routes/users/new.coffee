`import Em from 'ember'`

UsersNewRoute = Em.Route.extend
  model: ->
    @store.createRecord('user')

`export default UsersNewRoute`
