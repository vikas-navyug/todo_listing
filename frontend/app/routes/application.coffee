`import Ember from 'ember'`
`import constants from 'frontend/helpers/constants'`

route = Ember.Route.extend

  beforeModel:()->
    @getCurrentUser()

  getCurrentUser:()->
    that = this
    ($.ajax
      url: constants.LOGGED_IN_USER_URL
      type: 'GET'
      ).then(
        (data)->
          if data.message == 'Nobody logged In'
            that.transitionTo('login')
          else
            that.get('session').initialize(data)
      )

`export default route`
