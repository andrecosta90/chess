# frozen_string_literal: true

require './lib/players/player'

class NaivePlayer < Player
  def translate_input(board)
    value = nil
    board.pieces.each do |piece|
      value = piece.first_valid_movement
      return value unless value.nil?
    end
  end

  def select_option
    1
  end
end
