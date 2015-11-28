`import DS from 'ember-data'`

User = DS.Model.extend
  email: DS.attr 'string'
  firstName: DS.attr 'string'
  lastName: DS.attr 'string'
  name: (->
    @get('firstName') + " " + @get('lastName')
  ).property('firstName', 'lastName')

`export default User`
