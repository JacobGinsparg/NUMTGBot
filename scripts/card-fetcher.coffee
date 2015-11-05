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
  robot.hear /\[\[(.[\w|\,| |/|'|_|(|)|.]+)\]\]+/i, (msg) ->
