# frozen_string_literal: true

require './lib/board'
require './lib/pieces/king'

# rubocop:disable Metrics/BlockLength
describe King do
  subject(:piece) { described_class.new(true) }

  describe '#movable_items' do
    context 'when the king is in the center of the board' do
      let(:x) { 3 }
      let(:y) { 3 }

      it 'returns all possible candidate moves' do
        expect(piece.movable_items([x, y])).to eql([[2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4]])
      end
    end

    context 'when the king is in the top-right corner' do
      let(:x) { 0 }
      let(:y) { 7 }

      it 'returns the possible candidate moves' do
        expect(piece.movable_items([x, y])).to eql([[0, 6], [1, 6], [1, 7]])
      end
    end

    context 'when the king is in the bottom-left corner' do
      let(:x) { 7 }
      let(:y) { 0 }

      it 'returns the possible candidate moves' do
        expect(piece.movable_items([x, y])).to eql([[6, 0], [6, 1], [7, 1]])
      end
    end
  end

  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:piece) { described_class.new(true) }
    let(:source) { [4, 4] }

    before do
      board.update(source[0], source[1], piece)
      board.update(3, 4, described_class.new(true))  # White piece
      board.update(5, 4, described_class.new(false)) # Black piece
    end

    context 'when the king tries an invalid move' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [6, 4], board)).to be false
      end
    end

    context 'when the king tries to leap' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [2, 4], board)).to be false
      end
    end

    context 'when the king makes a valid move' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [4, 5], board)).to be true
      end
    end

    context 'when the white king tries to capture a white piece' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [3, 4], board)).to be false
      end
    end

    context 'when the white king tries to capture a black piece' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [5, 4], board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
