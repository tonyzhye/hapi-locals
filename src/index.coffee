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
    destContext = {}
    if response.variety is "view"
      Hoek.merge(destContext, context)
      Hoek.merge(destContext,
        response.source.context or {},
        options.isNullOverride,
        options.isMergeArrays)
      response.source.context = destContext

    return reply.continue()

  return next()

exports.register.attributes =
  pkg: require("../package.json")
