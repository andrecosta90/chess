# frozen_string_literal: true

require './lib/board'

class Game
  # attr_reader :board

  def initialize(white_player, black_player)
    @board = Board.new
    @players = [white_player, black_player]

    @index = 0
    @current_player = @players[@index]

    @messages = []
    @round_message = ''
  end

  # rubocop:disable Metrics
  def run
    loop do
      show
      @round_message = ''
      # 1. check the movement is valid :: from src to target
      # 2. if false => returns an error message
      # 3. if true => make move
      # 4. any capture ? promotion ?
      begin
        @current_player.make_move(@board)
        @round_message = "Success!\n".green.bold
        switch_players!
      rescue StandardError => e
        @round_message = "#{e}\n".red
      end
    end
  end

  def show
    # system 'clear'
    puts "\n*** MY CHESS GAME***\n".green.bold
    n = @board.size
    puts
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    n.times do |i|
      print "#{n - i}  ".green
      n.times do |j|
        piece = @board.select_piece_from([i, j])
        square = (i + j).even? ? piece.to_s.bg_yellow : piece.to_s.bg_red
        print square
      end
      print "  #{n - i}".green
      puts
    end
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    puts
    # puts @messages.last(3).join("\n")
    puts @round_message
    puts captured_display
    puts
  end
  # rubocop:enable Metrics

  private

  def captured_display
    "#{@players[0].captured_pieces}\n#{@players[1].captured_pieces}"
  end

  def switch_players!
    @index = 1 - @index
    @current_player = @players[@index]
  end
end
