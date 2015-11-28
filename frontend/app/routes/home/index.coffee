`import Em from 'ember'`

HomeIndexRoute = Em.Route.extend
  beforeModel: ->
    @transitionTo 'home.dashboard'

`export default HomeIndexRoute`
