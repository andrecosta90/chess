# frozen_string_literal: true

require './lib/board'

class Game
  # attr_reader :board

  def initialize(white_player, black_player)
    @board = Board.new
    @board.default_state
    @players = [white_player, black_player]

    @index = 0
    @current_player = @players[@index]

    @round_message = ''
  end

  def display_board
    system 'clear'
    puts "*** MY CHESS GAME ***\n".green.bold
    display_coordinates
    display_pieces
    display_coordinates
    display_messages
    reset_round_message
  end

  def over?
    status = @current_player.make_move(@board)
    @current_player.promote(status[:promoted_piece], @board) unless status[:promoted_piece].nil?
    process(status)
  rescue StandardError => e
    display_error(e)
    false
  end

  private

  def process(status)
    @round_message = "\nSuccess!\n".green.bold + (status[:is_in_check] ? "Check!\n\n" : '')
    if status[:game_over]
      puts "\n#{@current_player} is the WINNER!\n\n"
      return true
    end
    switch_players!
    false
  end

  def display_coordinates
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
  end

  def display_pieces
    @board.size.times do |i|
      print "#{@board.size - i}  ".green
      @board.size.times { |j| print square_display(i, j) }
      print "  #{@board.size - i}".green
      puts
    end
  end

  def square_display(row, col)
    piece = @board.select_piece_from([row, col])
    background_color = (row + col).even? ? :bg_yellow : :bg_red
    piece.to_s.send(background_color)
  end

  def display_messages
    puts @round_message
    puts captured_display
    puts
  end

  def reset_round_message
    @round_message = ''
  end

  def display_error(error)
    # @round_message = "#{error}\n#{error.backtrace.join("\n")}\n".red
    @round_message = "\n#{error}\n".red
  end

  def captured_display
    "#{@players[0].captured_pieces}\n#{@players[1].captured_pieces}"
  end

  def switch_players!
    @index = 1 - @index
    @current_player = @players[@index]
  end
end
