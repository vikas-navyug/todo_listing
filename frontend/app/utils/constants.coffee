constants =
  HOST: ''
  APP_NAME: 'My App'

constants.LOGOUT_URL = constants.HOST + '/sign_out'
constants.LOGGED_IN_USER_URL = constants.HOST + '/users/logged_in'
constants.SIGN_IN_URL = constants.HOST + "/users/sign_in"
constants.SIGN_UP_URL = constants.HOST + "/users/sign_up"
constants.FORGOT_PASSWORD_URL = constants.HOST + '/users/forgot_password'
constants.RESET_PASSWORD_URL = constants.HOST + '/auth/password'
constants.CHANGE_PASSWORD_URL = constants.HOST + '/users/change_password'

`export default constants`
