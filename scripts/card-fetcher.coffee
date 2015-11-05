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

# verifyCardName(cardName)
verifyCardName = (cardName) ->


# getCardImageUrl(cardName)
getCardImageUrl = (cardName) ->


module.exports = (robot) ->
  robot.hear rCardNames, (msg) ->
    valid = verifyCardName(msg.match[1])
    msg.send getCardImageUrl(msg.match[1]) if valid
