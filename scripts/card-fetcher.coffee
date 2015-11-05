# Description:
#   Card image fetcher for Magic: The Gathering cards
#
# Commands:
#   [[<card name>]]
#
# Notes:
#   Upon failure, returns Dismal Failure
#
# Author:
#   JacobGinsparg

loadCardDatabase = ->
  req = new XMLHttpRequest()
  req.addEventListener 'readystatechange', ->
    if req.readyState is 4 and req.status is 200
      data = eval req.responseText
  req.open 'GET', '../AllCards.json', false
  req.send()

getCardImageUrl = (cardName, cardDB) ->
  fullUrl = "http://gatherer.wizards.com/Handlers/Image.ashx?type=card&name=#{if cardName in cardDB then encodeURIComponent(cardName) else "Dismal%20Failure"}"

module.exports = (robot) ->
  robot.hear /\[\[(.*)\]\]/i, (msg) ->
    msg.send getCardImageUrl msg.match[1], loadCardDatabase()
