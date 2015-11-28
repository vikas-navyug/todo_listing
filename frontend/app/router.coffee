`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ()->
  @route 'login', path: '/sign_in'
  @route 'home', {resetNamespace: true}, ->
    @route 'dashboard'
    @route 'users', {resetNamespace: true}, ->
      @route 'new'
      @route 'show', {path: '/:id'}
      @route 'edit', {path: '/:id/edit'}

`export default Router`
