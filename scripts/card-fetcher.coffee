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

verifyCard = (cardName, cardDB) ->
  if cardName.search(" // ") isnt -1
    splitCards = cardName.split " // "
    return encodeURIComponent(cardName) if splitCards[0] of cardDB and splitCards[1] of cardDB
  else
    console.log "Encoded: " + encodeURIComponent(cardName)
    console.log "Not encoded: " + cardName
    matches = Object.keys cardDB .filter (key) ->
      /Ach! Hans, Run!/.test key
    console.log matches
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
        console.log msg.match[1]
        msg.send getCardImageUrl(msg.match[1], cards)
