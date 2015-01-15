Hapi Locals
===========

A Hapi plugin to add local variables and functions to all templates rendered.

## Goal:
Add server method "locals" to add global variables and functions for all templates. Just like app.locals in expressjs.

## How to use

```javascript

// register plugin
plugins = [];

plugins.push({
  register: require("./lib/hapi-locals")
});

server.register(plugins, function(err) {
  if (err) {
    throw err;
  }
});

// set local variable or function
server.methods.locals("siteTitle", "My SiteTitle");

server.methods.locals("sayHi", function(name) {
  return "Hello " + name;
});
```

```jade
title #{siteTitle}

p!= sayHi("Tony")
```
