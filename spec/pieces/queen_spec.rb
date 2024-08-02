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
      board.update(3, 4, described_class.new(true))
      board.update(3, 3, described_class.new(true))
      board.update(1, 7, described_class.new(true))
      board.update(7, 4, described_class.new(false))
      board.update(7, 7, described_class.new(false))
    end

    context 'when queen tries an invalid move' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [6, 3], board)).to be false
      end
    end

    context 'when queen tries to leap' do
      it 'returns false (i)' do
        expect(piece.valid_movement?(source, [2, 4], board)).to be false
      end

      it 'returns false (ii)' do
        expect(piece.valid_movement?(source, [2, 2], board)).to be false
      end
    end

    context 'when queen tries an valid move (i)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [6, 4], board)).to be true
      end
    end

    context 'when queen tries an valid move (ii)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [7, 1], board)).to be true
      end
    end

    context 'when queen tries an valid move (iii)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [2, 6], board)).to be true
      end
    end

    context 'when white queen tries try to capture a white piece' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [3, 4], board)).to be false
      end
    end

    context 'when white queen tries try to capture a black piece' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [5, 4], board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
