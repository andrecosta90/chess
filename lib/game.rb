# frozen_string_literal: true

require './lib/board'

class Game
  attr_reader :board

  INPUT_PATTERN = Regexp.new(/^(?:[a-h][1-8]){2}$/)

  def initialize
    @board = Board.new

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
        value = input
        board.move(value[...2], value[2..])
        @round_message = 'Success!'.green.bold
      rescue StandardError => e
        @round_message = e.to_s.red
      end
    end
  end

  private

  def input
    value = gets.strip
    raise StandardError, "Invalid input from user :: value='#{value}'" if INPUT_PATTERN.match(value).nil?

    value
  end

  def show
    system 'clear'
    puts "\n*** MY CHESS GAME***\n".green.bold
    n = board.size
    puts
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    n.times do |i|
      print "#{n - i}  ".green
      n.times do |j|
        piece = board.select_piece_from([i, j])
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
    puts
  end
  # rubocop:enable Metrics

  def move(number)
    return false if number.even?

    true
  end
end
