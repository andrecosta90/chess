# frozen_string_literal: true

class Piece
  def initialize(white, symbol)
    @white = white
    @symbol = symbol
    @n_movements = 0
  end

  def update
    @n_movements += 1
  end

  def same_player?(target, board)
    return false if board.empty?(target)

    board.select_piece_from(target).white? == white?
  end

  def valid_movement?(source, target, board)
    return false if same_player?(target, board)
    return false if source == target

    true
  end

  def white?
    @white
  end

  def to_s
    @symbol
  end

  private

  def out_of_range?(value)
    (value[0].negative? || value[0] > 7) || (value[1].negative? || value[1] > 7)
  end

  def trim_path(range, signal)
    range = signal.positive? ? range.reject(&:negative?) : range # TODO: DRY !!
    range.to_a[1...-1]
  end

  def permutations; end
end
