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
    return false if source == target # TODO: Refactor me please!!!

    true
    # TODO: Refactor me please!!
    # maybe this function is usefull only for PAWN
    #
    # p source
    # p target
    # candidates = movable_items(source).select { |pos| board.empty?(pos) }
    # captured_candidates = capturable_items(source).reject do |pos|
    #   board.empty?(pos) || board.select_piece_from(pos).white? == white?
    # end
    # p candidates

    # candidates.include?(target) || captured_candidates.include?(target)
  end

  def movable_items(source)
    arr = permutations
    items = arr.map { |param| move_item(source, param) }
    items.reject { |value| out_of_range?(value) }
  end

  def capturable_items(source)
    movable_items(source)
  end

  def white?
    @white
  end

  def to_s
    @symbol
  end

  private

  def move_item(source, param)
    [source[0] + param[0], source[1] + param[1]]
  end

  def out_of_range?(value)
    (value[0].negative? || value[0] > 7) || (value[1].negative? || value[1] > 7)
  end

  # def trim_path(range, signal)
  #   range = signal.positive? ? range.reject(&:negative?) : range # TODO: DRY !!
  #   range.to_a[1...-1]
  # end

  def permutations; end
end
