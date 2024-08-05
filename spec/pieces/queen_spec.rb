# frozen_string_literal: true

require './lib/board'
require './lib/pieces/queen'

# rubocop:disable Metrics/BlockLength
describe Queen do
  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:piece) { described_class.new(true) }
    let(:source) { [4, 4] }

    before do
      board.update(source[0], source[1], piece)
      board.update(3, 4, described_class.new(true))  # Blocked move vertically
      board.update(3, 3, described_class.new(true))  # Blocked move diagonally
      board.update(1, 7, described_class.new(true))  # Blocked move diagonally
      board.update(7, 4, described_class.new(false)) # Opponent piece vertically
      board.update(7, 7, described_class.new(false)) # Opponent piece diagonally
    end

    context 'when the queen tries an invalid move' do
      it 'returns false for a move not aligned with queen\'s movement' do
        expect(piece.valid_movement?(source, [6, 3], board)).to be false
      end
    end

    context 'when the queen tries to leap over pieces' do
      it 'returns false for a vertical move blocked by an own piece' do
        expect(piece.valid_movement?(source, [2, 4], board)).to be false
      end

      it 'returns false for a diagonal move blocked by an own piece' do
        expect(piece.valid_movement?(source, [2, 2], board)).to be false
      end
    end

    context 'when the queen makes a valid move' do
      it 'returns true for a valid vertical move' do
        expect(piece.valid_movement?(source, [6, 4], board)).to be true
      end

      it 'returns true for a valid diagonal move' do
        expect(piece.valid_movement?(source, [7, 1], board)).to be true
      end

      it 'returns true for another valid diagonal move' do
        expect(piece.valid_movement?(source, [2, 6], board)).to be true
      end
    end

    context 'when the queen tries to capture pieces' do
      it 'returns false when capturing a piece of the same color' do
        expect(piece.valid_movement?(source, [3, 4], board)).to be false
      end

      it 'returns true when capturing an opponent\'s piece' do
        expect(piece.valid_movement?(source, [7, 4], board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
