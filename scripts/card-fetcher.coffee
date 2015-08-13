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

module.exports = (robot) ->
  robot.hear /\[\[(.[\w|\,| |/]+)\]\]+/i, (msg) ->
    url = "http://gatherer.wizards.com/Handlers/Image.ashx"
    card = msg.match[1]
    cardCheckUrl = "https://api.deckbrew.com/mtg/cards?name=#{card}"
    robot.http(cardCheckUrl)
      .get() (err, res, body) ->
        jsonBody = JSON.parse body
        firstMatch = jsonBody[0]["name"] if jsonBody.length != 0
        if firstMatch.toUpperCase() != card.toUpperCase()
          msg.send "#{url}?type=card&name=Dismal%20Failure"
        else
          msg.send "#{url}?type=card&name=#{encodeURIComponent(card)}"
