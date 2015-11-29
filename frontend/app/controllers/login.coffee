`import Ember from 'ember'`
`import constants from 'frontend/helpers/constants'`

controller = Ember.Controller.extend

  actions:
    login:()->
      email = @get('email')
      password = @get('password')
      that = this
      $.ajax
        url: constants.SIGN_IN_URL
        type: 'POST'
        data:{username: email, password: password}
        success:()->
          alert('User Logged in Successfully')
          that.transitionToRoute('home')
        error:(error)->
          alert(error.message)


`export default controller`
