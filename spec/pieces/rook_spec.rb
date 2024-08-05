# frozen_string_literal: true

require './lib/board'
require './lib/pieces/rook'

# rubocop:disable Metrics/BlockLength
describe Rook do
  subject(:piece) { described_class.new(true) }

  describe '#same_row_or_column?' do
    context 'when the target is on the same row as the source' do
      let(:source) { [7, 2] }
      let(:target) { [7, 5] }

      it 'returns true' do
        expect(piece.same_row_or_column?(target, source)).to be true
      end
    end

    context 'when the target is on the same column as the source' do
      let(:source) { [3, 5] }
      let(:target) { [1, 5] }

      it 'returns true' do
        expect(piece.same_row_or_column?(target, source)).to be true
      end
    end

    context 'when the target is not on the same row or column as the source' do
      let(:source) { [7, 2] }
      let(:target) { [4, 3] }

      it 'returns false' do
        expect(piece.same_row_or_column?(target, source)).to be false
      end
    end
  end

  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:piece) { described_class.new(true) }

    let(:source) { [4, 4] }

    before do
      board.update(source[0], source[1], piece)
      board.update(3, 4, described_class.new(true))  # Blocked move vertically
      board.update(7, 4, described_class.new(false)) # Opponent piece vertically
    end

    context 'when the rook tries an invalid move' do
      it 'returns false for a diagonal move' do
        expect(piece.valid_movement?(source, [5, 0], board)).to be false
      end
    end

    context 'when the rook tries to leap over pieces' do
      it 'returns false for a move blocked by an own piece' do
        expect(piece.valid_movement?(source, [2, 4], board)).to be false
      end
    end

    context 'when the rook makes a valid move' do
      it 'returns true for a valid vertical move' do
        expect(piece.valid_movement?(source, [6, 4], board)).to be true
      end

      it 'returns true for a valid horizontal move' do
        expect(piece.valid_movement?(source, [4, 7], board)).to be true
      end
    end

    context 'when the rook tries to capture pieces' do
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
