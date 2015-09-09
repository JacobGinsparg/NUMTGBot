# Description
#   Snippy puts the table back
#
# Commands
#   (╯°□°)╯︵ ┻━┻

module.exports = (robot) ->
  robot.hear /(\(╯°□°\)╯︵ ┻━┻)/i, (res) ->
    res.send "┬──┬ ノ( ಠ_ಠノ)"
