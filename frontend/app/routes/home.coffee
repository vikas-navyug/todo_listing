`import Em from 'ember'`

HomeRoute = Em.Route.extend
  setupController: (controller, model)->
    @_super()
    unless @get('session.currentUser')
      @transitionTo('login')

`export default HomeRoute`
