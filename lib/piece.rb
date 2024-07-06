# frozen_string_literal: true

class Piece
  def initialize(is_white)
    @symbol = (is_white ? ' ♞  ' : ' ♘  ').black
  end
end
