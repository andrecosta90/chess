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

  def can_reach_target?(source, target, board)
    movable_candidates = movable_items(source).select { |pos| board.empty?(pos) }
    capturable_candidates = capturable_items(source).reject do |pos|
      board.empty?(pos) || board.select_piece_from(pos).white? == white?
    end

    movable_candidates.include?(target) || capturable_candidates.include?(target)
  end

  def white?
    @white
  end

  def to_s
    @symbol
  end

  private

  def movable_items(source)
    arr = candidates
    items = arr.map { |param| move_item(source, param) }
    items.reject { |value| out_of_range?(value) }
  end

  def capturable_items(source)
    movable_items(source)
  end

  def move_item(source, param)
    [source[0] + param[0], source[1] + param[1]]
  end

  def out_of_range?(value)
    (value[0].negative? || value[0] > 7) || (value[1].negative? || value[1] > 7)
  end

  def trim_path(range, signal)
    range = signal.positive? ? range.reject(&:negative?) : range
    range.to_a[1...-1]
  end

  def candidates; end
end
