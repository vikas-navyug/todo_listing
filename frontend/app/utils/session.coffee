`import Em from 'ember'`
`import CONST from 'frontend/utils/constants'`

Session = Em.Object.extend
  isAuthenticated: false
  currentUser: null
  appName: CONST.APP_NAME

  initialize: (userInfo)->
    user = null
    if userInfo.user and userInfo.user.id
      user = userInfo.user
      currentUser =  @store.find('user', userInfo.user.id)
      @set 'currentUser', currentUser
    @setupInitialPermissions(userInfo.meta)
    currentUser		# returning a user promise

  setupInitialPermissions: (permissions)->

`export default Session`
