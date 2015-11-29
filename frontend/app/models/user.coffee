`import DS from "ember-data"`

model = DS.Model.extend

  firstname: DS.attr('string')
  lastname: DS.attr('string')
  email: DS.attr('string')


`export default model`
