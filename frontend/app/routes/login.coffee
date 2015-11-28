`import Em from 'ember'`
`import Http from 'frontend/utils/http'`
`import CONST from 'frontend/utils/constants'`

LoginRoute = Em.Route.extend
  beforeModel:->
    @_super()		# making default beforeModel hook run
    session = @get('session')
    current_user = session.get('currentUser')
    if current_user
      @transitionTo('home')

  actions:
    login: ()->
      that = this
      session = @get('session')
      payload =
        username: @controller.get('userName')
        password: @controller.get('password')
      Http.ajax(CONST.SIGN_IN_URL, 'POST', {data: payload}, this)
      .then((resp, status, xhr)->
        if status == 'success'
          session.initialize(resp)
          that.transitionTo 'home'
        else
          console.error("error")
      , (xhr, status, code)->
        message = 'error occured'
        resp = xhr.responseJSON
        message = (resp and resp.message) || message
        alert message
      )

`export default LoginRoute`
