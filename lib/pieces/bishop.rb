# frozen_string_literal: true

class Bishop < Piece
  CODE_POINT = " \u2657  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)
    return false unless same_diagonal?(target, source)

    p "source= #{source}"
    p "target= #{target}"
    p "movement_direction= #{movement_direction(target, source)}"

    valid_path?(source, target, board)
  end

  private

  def valid_path?(source, target, board)

    array = movement_range(source, target)
    p "path= #{array.to_a}"

    board.path_free?(array)
  end

  def same_diagonal?(target, source)
    (target[0] - source[0]).abs == (target[1] - source[1]).abs
  end

  def movement_direction(target, source)
    [
      (target[0] - source[0]).negative? ? -1 : 1,
      (target[1] - source[1]).negative? ? -1 : 1
    ]
  end

  def movement_range(source, target)
    range_x = get_range(source[0], target[0])
    range_y = get_range(source[1], target[1])
    range_x.zip(range_y)
  end

  def get_range(src, tgt)
    signal = src > tgt ? -1 : 1
    range = (signal * src..signal * tgt)
    signal.positive? ? range.reject(&:negative?) : range # TODO: DRY !!
    range.to_a[1...-1].map(&:abs)
  end
end
