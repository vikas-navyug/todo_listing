`import Ember from 'ember'`
`import constants from 'frontend/helpers/constants'`

Session = Ember.Object.extend
  isAuthenticated: false
  currentUser: null
  appName: constants.APP_NAME

  initialize: (user)->
    if user.id
      that = this
      userPromise = @store.findRecord('user', user.id).then(
        (user)->
          that.set 'currentUser', userPromise
      )
      userPromise

`export default Session`
