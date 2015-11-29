`import DS from 'ember-data'`

adapter = DS.Adapter.extend
  findRecord: (store, type, id, snapshot) ->
    url = [
      type.modelName.pluralize()
      id
    ].join('/')
    new (Ember.RSVP.Promise)((resolve, reject) ->
      Ember.$.getJSON(url).then ((data) ->
        debugger
        Ember.run null, resolve, data
        return
      ), (jqXHR) ->
        jqXHR.then = null
        # tame jQuery's ill mannered promises
        Ember.run null, reject, jqXHR
        return
      return
  )

`export default adapter`
