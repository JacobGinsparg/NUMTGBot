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

cardDatabaseUrl = "http://mtgjson.com/json/AllCards.json"
urlBase = "http://gatherer.wizards.com/Handlers/Image.ashx?type=card&name="

getCardImageUrl = (cardName, cardDB) ->
  encodedName = if decodeURIComponent(cardName) of cardDB then encodeURIComponent(cardName) else "Dismal%20Failure"
  fullUrl = "#{urlBase}#{encodedName}"

module.exports = (robot) ->
  robot.hear /\[\[(.*)\]\]/i, (msg) ->
    robot.http(cardDatabaseUrl)
      .get() (err, res, body) ->
        cards = JSON.parse body
        msg.send getCardImageUrl(msg.match[1], cards)
