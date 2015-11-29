`import Ember from 'ember'`
`import constants from 'frontend/helpers/constants'`

route = Ember.Route.extend

  beforeModel:()->
    return Ember.RSVP.all[@getCurrentUser()]

  getCurrentUser:()->
    that = this
    ($.ajax
      url: constants.LOGGED_IN_USER_URL
      type: 'GET'
      ).then(
        (data)->
          if data.message != 'Nobody logged In'
            that.store.find('user',data.id).then(
              (user)->
                that.get('session').set('currentUser',user)
            )
      )

`export default route`
