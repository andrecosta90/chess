# frozen_string_literal: true

require './lib/game'
require './lib/player'

white_player = Player.new(true)
black_player = Player.new(false)

game = Game.new(white_player, black_player)
game.run
