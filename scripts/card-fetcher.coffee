# Description:
#   Card image fetcher for Magic: The Gathering cards
#
# Commands:
#   [[<card name>]]
#   [[<left name> // <right name>]]
#
# Notes:
#   Upon failure, returns Dismal Failure
#
# Author:
#   JacobGinsparg

cardDatabaseUrl = "http://mtgjson.com/json/AllCards.json"
urlBase = "http://gatherer.wizards.com/Handlers/Image.ashx?type=card&name="
uniQuotes = /“|”/

doReplacement = (str) ->
  return str.replace uniQuotes, "\"", "g"

verifyCard = (cardName, cardDB) ->
  while uniQuotes.test cardName
    cardName = doReplacement cardName
  if cardName.search(" // ") isnt -1
    splitCards = cardName.split " // "
    return encodeURIComponent(cardName) if splitCards[0] of cardDB and splitCards[1] of cardDB
  else
    return encodeURIComponent(cardName) if cardName of cardDB
  "Dismal%20Failure"

getCardImageUrl = (cardName, cardDB) ->
  verifiedCard = verifyCard(cardName, cardDB)
  fullUrl = "#{urlBase}#{verifiedCard}"

module.exports = (robot) ->
  robot.hear /\[\[(.*)\]\]/i, (msg) ->
    robot.http(cardDatabaseUrl)
      .get() (err, res, body) ->
        cards = JSON.parse body
        msg.send getCardImageUrl(msg.match[1], cards)
