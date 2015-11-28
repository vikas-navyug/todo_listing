`import Em from 'ember'`

IndexRoute = Em.Route.extend
  beforeModel: ()->
    @get('session.currentUser')     # wait for current user to be resolved by returning a promise
  afterModel: ()->
    if @get('session.currentUser.id')  # till now the current user has been resolved
      @transitionTo 'home'
    else
      @transitionTo 'login'

`export default IndexRoute`
