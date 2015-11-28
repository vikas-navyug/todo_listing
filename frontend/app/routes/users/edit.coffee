`import Em from 'ember'`

UsersNewRoute = Em.Route.extend
  model: (params)->
    @store.find('user', params.id)

`export default UsersNewRoute`
