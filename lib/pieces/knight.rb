# frozen_string_literal: true

class Knight < Piece
  CODE_POINT = " \u2658  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  # rubocop:disable Metrics
  # TODO: Refactor me
  def movable_items(source)
    items = [
      [source[0] + 1, source[1] + 2],
      [source[0] + 2, source[1] + 1],
      [source[0] + 2, source[1] - 1],
      [source[0] + 1, source[1] - 2],
      [source[0] - 1, source[1] - 2],
      [source[0] - 2, source[1] - 1],
      [source[0] - 1, source[1] + 2],
      [source[0] - 2, source[1] + 1]
    ]

    items.reject { |value| out_of_range?(value[0]) || out_of_range?(value[1]) }
  end
  # rubocop:enable Metrics

  def capturable_items(source)
    movable_items(source)
  end
end
