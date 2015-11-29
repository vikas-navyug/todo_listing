# writing ajax method so in case we need to put any ajax. This method should be used instead of plain
# jquery ajax. This will help keeping the code modular and ajax requests traceable.
Http =
  ajax: (url, type, hash, context) ->
    if type.toLowerCase() isnt 'get' and hash.data isnt null
      hash.data = JSON.stringify(hash.data)
    hash.url = url
    hash.type = type
    hash.dataType = 'json'
    hash.contentType = 'application/json; charset=utf-8'
    hash.context = context || this
    $.ajax(hash)

`export default Http`
