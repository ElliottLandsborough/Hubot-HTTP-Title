# Hubot-HTTP-Title

## What is this?

A script that makes Hubot reply with the title of a page when someone types a url into the channel.

## What is this based on?

This: https://github.com/github/hubot-scripts/blob/master/src/scripts/http-info.coffee

## What are its dependencies?
 - node - https://github.com/joyent/node
 - hubot - https://github.com/github/hubot
 - request - https://github.com/request/request
 - cheerio - https://github.com/cheeriojs/cheerio
 - underscore - https://github.com/jashkenas/underscore

## Why does this exist?

Importing jsdom into a hubot script was broken with this error:

```
hubot/node_modules/jsdom/lib/jsdom/living/helpers/validate-names.js:2
const xnv = require("xml-name-validator");
^^^^^

/hubot/node_modules/hubot-scripts/src/scripts/http-info: SyntaxError: Use of const in strict mode.
```

