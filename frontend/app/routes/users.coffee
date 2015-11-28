`import Em from 'ember'`

UsersRoute = Em.Route.extend
  model: ->
    @store.query('user', {})
  setupController:(controller, model)->
    controller.set 'model', model
  actions:
    saveUser: (user)->
      user.save()
      .then (savedUser)=>
        alert("saved")
      ,
        (error)=>
          msg = ''
          for key of error.errors
            value = error.errors[key]
            value.forEach (err)->
              msg = msg + key + ': ' + err
          alert(msg)

`export default UsersRoute`
