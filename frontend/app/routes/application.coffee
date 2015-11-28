`import Em from 'ember'`
`import Http from 'frontend/utils/http'`
`import CONST from 'frontend/utils/constants'`

ApplicationRoute = Em.Route.extend
  beforeModel: ->
#		Before the model hook is called we will query the backend for current_user. If it exists then we will set our Application's
#		user to that user. Otherwise we will wait for user sign in or sign up.
      that = this
      success = (data)->
        if data['message'] != 'Nobody logged In'
          that.get('session').initialize({user: data})
      Http.ajax(CONST.LOGGED_IN_USER_URL, 'GET', {}, this).then(success)

  model: ()->
    @get('controller.session.currentUser')

  renderErrorPage: (template) ->
    @render('application')
    @render template,
      into: 'application'
      outlet:'main'

  actions:
    verifyAndSignIn: ()->
      hash =
        success: (data)->
          if data['message'] != 'Nobody logged In'
            @get('session').initialize(data)
            @controller.set('model',@get('session.currentUser'))
            @transitionTo 'index'
      Http.ajax CONST.LOGGED_IN_USER_URL, 'get', hash, this

    logout: ->
      hash =
        success: ()->
          location.reload()
      Http.ajax CONST.HOST + CONST.LOGOUT_URL, 'GET', hash, this


`export default ApplicationRoute`
