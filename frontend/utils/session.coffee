`import Ember from 'ember'`
`import constants from 'frontend/helpers/constants'`

Session = Ember.Object.extend
  isAuthenticated: false
  currentUser: null
  appName: constants.APP_NAME

  initialize: (user)->
    user = null
    that = this
    if user.id
      user = userInfo.user
      @store.findRecord('user', user.id).then(
        (userRecord)->
          that.set 'currentUser', userRecord
      )

`export default Session`
