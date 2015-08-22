Hoek    = require("hoek")

context = {}

exports.register = (server, options, next) ->
  options = Hoek.applyToDefaults({
    isNullOverride: true
    isMergeArrays: true
  }, options)

  locals = (key, value) ->
    context[key] = value

  server.method
    name: "locals"
    method: locals,
    options: {}

  server.ext "onPostHandler", (request, reply) ->
    response = request.response
    if response.variety is "view"
      response.source.context = Hoek.merge(context, 
                                           response.source.context or {}, 
                                           options.isNullOverride, 
                                           options.isMergeArrays)

    return reply.continue()

  return next()
  
exports.register.attributes = 
  pkg: require("../package.json")

