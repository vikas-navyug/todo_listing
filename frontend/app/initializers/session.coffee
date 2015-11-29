`import Ember from 'ember'`
`import Session from 'frontend/helpers/session'`

SessionInitializer =
  name: 'injectSession'
  initialize: (registry, app)->
    app.register('service:session', Session)
    app.inject('controller', 'session', 'service:session')
    app.inject('route', 'session', 'service:session')
    app.inject('service:session', 'store', 'service:store')

`export default SessionInitializer`
