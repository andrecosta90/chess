# frozen_string_literal: true

require './lib/board'

# Represents the chess game, managing the board, players, and game flow.
#
# The Game class is responsible for initializing and maintaining the state of a chess game,
# including setting up the board, managing player turns, and handling game state updates.
# It provides functionality to display the board, process moves, handle game end conditions,
# and manage messages related to the game's progress.
class Game
  # Initializes a new game with two players.
  def initialize(white_player, black_player)
    @board = Board.new
    @board.default_state
    @players = [white_player, black_player]

    @index = 0
    @current_player = @players[@index]

    @round_message = ''
  end

  # Clears the screen and prints the current state of the board along with messages.
  def display_board
    system 'clear'
    puts "*** AWESOME CHESS GAME ***\n".green.bold
    display_coordinates
    display_pieces
    display_coordinates
    display_messages
    reset_round_message
  end

  # Processes the current player's move, updates the board, and checks for game end conditions.
  def over?
    status = @current_player.make_move(@board)
    @current_player.promote(status[:promoted_piece], @board) unless status[:promoted_piece].nil?
    process(status)
  rescue StandardError => e
    display_error(e)
    false
  end

  private

  # Processes the result of a player's move, updates the round message, and checks for game end conditions.
  def process(status)
    @round_message = "\nSuccess!\n".green.bold + (status[:is_in_check] ? "Check!\n\n" : '')
    if status[:game_over]
      @round_message += "\nCHECKMATE !! #{@current_player} is the WINNER!\n\n"
      return true
    end
    switch_players!
    false
  end

  # Prints the column coordinates (a to h) for the board.
  def display_coordinates
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
  end

  # Prints the current state of the board with pieces placed on it.
  def display_pieces
    @board.size.times do |i|
      print "#{@board.size - i}  ".green
      @board.size.times { |j| print square_display(i, j) }
      print "  #{@board.size - i}".green
      puts
    end
  end

  # Returns a formatted string representing the piece on the given square.
  def square_display(row, col)
    piece = @board.select_piece_from([row, col])
    background_color = (row + col).even? ? :bg_yellow : :bg_red
    piece.to_s.send(background_color)
  end

  # Prints the current round message and captured pieces.
  def display_messages
    puts @round_message
    puts captured_display
    puts
  end

  # Resets the round message after displaying it.
  def reset_round_message
    @round_message = ''
  end

  # Displays error messages if an exception occurs during the game.
  def display_error(error)
    # @round_message = "#{error}\n#{error.backtrace.join("\n")}\n".red
    @round_message = "\n#{error}\n".red
  end

  # Returns a string representation of captured pieces for both players.
  def captured_display
    "#{@players[0].captured_pieces}\n#{@players[1].captured_pieces}"
  end

  # Switches the turn to the next player in the players array.
  def switch_players!
    @index = 1 - @index
    @current_player = @players[@index]
  end
end
