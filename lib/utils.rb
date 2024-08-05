# frozen_string_literal: true

# Utils class provides utility methods for converting chess board positions
# from notation format to array coordinates and vice versa.
class Utils
  # Converts a chess board position (e.g., 'b5') to array coordinates [rank, file]
  def self.get_coordinates(pos, size = 8)
    [parse_rank(pos[1], size), parse_file(pos[0])]
  end

  # Converts a file character (e.g., 'a') to an integer index (0-based)
  def self.parse_file(char)
    char.downcase.ord - 97
  end

  # Converts a rank character (e.g., '8') to an integer index (0-based)
  def self.parse_rank(char, size = 8)
    size - char.to_i
  end
end
