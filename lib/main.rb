# frozen_string_literal: true

require_relative 'color'
require_relative 'board'
require_relative 'pieces/pawn'

# N = 8

# puts
# puts "   #{(' A  '..' H  ').to_a.map(&:green).join('')}"
# N.times do |i|
#   print "#{N - i}  ".green
#   N.times do |j|
#     piece = ((i + j).odd? ? ' ♞  ' : ' ♘  ').black
#     square = (i + j).even? ? piece.bg_yellow : piece.bg_red
#     print square
#   end
#   print "  #{N - i}".green
#   puts
# end
# puts "   #{(' A  '..' H  ').to_a.map(&:green).join('')}"
# puts

# pawn = Pawn.new(true)
# p pawn
board = Board.new

loop do
  board.show
  input = gets.strip
  board.move(input[...2], input[2..])
end

# board.move([6, 4], [4, 4])
# board.show
