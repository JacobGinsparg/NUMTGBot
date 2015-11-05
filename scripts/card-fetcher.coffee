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

rCardNames = /\[\[(.*)\]\]/i
baseUrl = "http://gatherer.wizards.com/Handlers/Image.ashx"

loadCardDatabase = ->
  req = new XMLHttpRequest()
  req.addEventListener 'readystatechange', ->
    if req.readyState is 4 and req.status is 200
      data = eval '(' + req.responseText + ')'
    else
      data = "Error"
  req.open 'GET', '../AllCards.json', false
  req.send()

verifyCardName = (cardName, db) ->
  cardName in db

getCardImageUrl = (cardName, validCard) ->
  fullUrl = "#{baseUrl}?type=card&name=#{validCard ? encodeURIComponent(cardName) : "Dismal%20Failure"}"

module.exports = (robot) ->
  robot.hear rCardNames, (msg) ->
    cardDB = loadCardDatabase()
    valid = verifyCardName msg.match[1], cardDB
    msg.send getCardImageUrl msg.match[1], valid
