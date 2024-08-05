# frozen_string_literal: true

require 'readline'

require './lib/game'
require './lib/players/player'

# Manages the Chess game interface and interactions with the user.
#
# The Chess class provides the interface for starting a new game, loading a saved game,
# saving the current game state, and playing the game. It handles user inputs and
# manages the overall flow of the game.
#
class Chess
  # Starts the Chess game by displaying the main menu and handling user selection.
  def start
    puts '========================='
    puts "Welcome to Chess Game!\n\n"
    puts "\t1 - New game"
    puts "\t2 - Load game"
    puts "\n=========================\n\n"
    select_option
  end

  private

  # Prompts the user to choose between starting a new game or loading a saved game.
  # Continues to prompt until a valid option is chosen.
  def select_option
    loop do
      print 'Choose an option: '
      option = gets.to_i

      new_game if option == 1
      load_game(Readline.readline('Enter file name: ').strip) if option == 2

      break if option.between?(1, 2)

      puts "\nInvalid option! ** #{option} **\n\n"
    end
  end

  # Initializes a new game with a white and black player and starts the gameplay loop.
  def new_game
    puts "\nRunning new game...\n\n"
    white_player = Player.new(true)
    black_player = Player.new(false)

    game = Game.new(white_player, black_player)
    play(game)
  end

  # Loads a game from the specified file path and starts the gameplay loop.
  #
  # @param file_path [String] The path to the file containing the saved game state.
  def load_game(file_path)
    puts "Loading a game from path=#{file_path}..."
    play(Marshal.load(File.read(file_path)))
  rescue Errno::ENOENT
    puts "\nFile not found: #{file_path}\n\n"
  rescue TypeError
    puts "\nInvalid file format: #{file_path}\n\n"
  end

  # Saves the current game state to a file with a timestamped filename.
  #
  # @param game [Game] The game instance to be saved.
  def save(game)
    path = File.join(File.dirname(__FILE__), '../appdata')
    Dir.mkdir(path) unless Dir.exist?(path)
    id = Time.now.utc.strftime('%Y%m%d_%H%M%S')
    filename = "#{path}/chess_#{id}.data"
    File.open(filename, 'w') do |file|
      file.print Marshal.dump(game) # state.serialize
    end
    puts "\nSaving in #{filename}\n\n"
  end

  # Runs the game loop, displaying the board and checking for game over conditions.
  #
  # @param game [Game] The game instance to be played.
  def play(game)
    loop do
      game.display_board
      break game.display_board if game.over?
    rescue Interrupt => e
      p e
      save(game)
      break
    end
  end
end

# Start the chess game by creating a new Chess instance and calling `start`.
game = Chess.new
game.start
