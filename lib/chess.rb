# frozen_string_literal: true

require 'readline'

require './lib/game'
require './lib/player'

class Chess
  attr_reader :dictionary

  def initialize
    # @dictionary = Hangman::Utils.load_dictionary
  end

  # Starts the Chess game.
  def start
    puts '========================='
    puts "Welcome to Chess Game!\n\n"
    puts "\t1 - New game"
    puts "\t2 - Load game"
    puts '========================='
    select_option
  end

  private

  # Allows the player to choose between starting a new game or loading a saved game.
  def select_option
    loop do
      print 'Choose a option: '
      option = gets.to_i

      new_game if option == 1
      load_game(Readline.readline('Enter file name: ').strip) if option == 2

      break if option.between?(1, 2)

      puts "\nInvalid option! ** #{option} **\n\n"
    end
  end

  def new_game
    puts "\nRunning new game...\n\n"
    white_player = Player.new(true)
    black_player = Player.new(false)

    game = Game.new(white_player, black_player)
    play(game)
  end

  def load_game(file_path)
    puts "Loading a game path=#{file_path}..."
    play(Marshal.load(File.read(file_path)))
  rescue Errno::ENOENT
    puts "\nFile not found: #{file_path}\n\n"
  rescue TypeError
    puts "\nInvalid file format: #{file_path}\n\n"
  end

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

game = Chess.new
game.start
