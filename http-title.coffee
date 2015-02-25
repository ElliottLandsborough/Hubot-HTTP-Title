# Description:
#   Returns title when links are posted without depending on jsdom
#   npm install request --save 
#   npm install cheerio --save
#   npm install underscore --save
#
# Dependencies:
#   "request": "^2.53.0"
#   "cheerio": "^0.18.0"
#   "underscore": "^1.8.2"
#
# Configuration:
#   HUBOT_HTTP_INFO_IGNORE_URLS - RegEx used to exclude Urls
#   HUBOT_HTTP_INFO_IGNORE_USERS - Comma-separated list of users to ignore
#
# Commands:
#   http(s)://<site> - prints the title and meta description for sites linked.
#
# Author:
#   elliottLandsborough

request = require 'request'
cheerio = require 'cheerio'
_       = require 'underscore'

module.exports = (robot) ->

  ignoredusers = []
  if process.env.HUBOT_HTTP_INFO_IGNORE_USERS?
    ignoredusers = process.env.HUBOT_HTTP_INFO_IGNORE_USERS.split(',')

  robot.hear /(http(?:s?):\/\/(\S*))/i, (msg) ->
    url = msg.match[1]

    username = msg.message.user.name
    if _.some(ignoredusers, (user) -> user == username)
      console.log 'ignoring user due to blacklist:', username
      return

    # filter out some common files from trying
    ignore = url.match(/\.(png|jpg|jpeg|gif|txt|zip|tar\.bz|js|css)/)

    ignorePattern = process.env.HUBOT_HTTP_INFO_IGNORE_URLS
    if !ignore && ignorePattern
      ignore = url.match(ignorePattern)

    request.get { uri: url, json: false }, (err, r, body) ->
        
        $ = cheerio.load(body);
        
        title = $('head title').text();
        
        msg.send "#{title}"
