# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def initialize(white)
    super(white)
    @additive_factor = white ? -1 : 1
  end

  def move
    @n_movements += 1
  end

  def valid_movement?(source, target, board)
    candidates = get_candidates(source).select { |pos| board.empty?(pos) }
    capt_candidates = get_capture_candidates(source).reject do |pos|
      board.empty?(pos) || board.get_piece(pos).white == white
    end

    # need to track captures
    p target
    p candidates

    candidates.include?(target) || capt_candidates.include?(target)
  end

  private

  def get_capture_candidates(source)
    [
      [source[0] + @additive_factor, source[1] + 1],
      [source[0] + @additive_factor, source[1] - 1]
    ]
  end

  def get_candidates(source)
    array = [
      [source[0] + @additive_factor, source[1]]
    ]

    array.push([source[0] + (@additive_factor * 2), source[1]]) if @n_movements.zero?

    array
  end
end
