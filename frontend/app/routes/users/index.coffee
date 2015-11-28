`import Em from 'ember'`

UsersIndexRoute = Em.Route.extend
  model: ->
    @modelFor('users')

`export default UsersIndexRoute`
