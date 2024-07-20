# frozen_string_literal: true

class Bishop < Piece
  CODE_POINT = " \u2657  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false if source == target # TODO: Refactor me please!!!
    return false unless valid_path?(source, target, board)

    p "source= #{source}"
    p "target= #{target}"
    p "movement_direction= #{movement_direction(target, source)}"

    same_diagonal?(target, source)
  end

  private

  def valid_path?(source, target, board)
    # TODO: Code it !
    false
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
end
