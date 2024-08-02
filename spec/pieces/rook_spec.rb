# frozen_string_literal: true

require './lib/board'
require './lib/pieces/rook'

# rubocop:disable Metrics/BlockLength
describe Rook do
  subject(:piece) { described_class.new(true) }

  describe '#same_diagonal?' do
    context 'when the target is on the same row as the source' do
      let(:source) { [7, 2] }
      let(:target) { [7, 5] }

      it 'returns true' do
        expect(
          piece.same_row_or_column?(target, source)
        ).to be true
      end
    end

    context 'when the target is on the same column as the source' do
      let(:source) { [3, 5] }
      let(:target) { [1, 5] }

      it 'returns true' do
        expect(
          piece.same_row_or_column?(target, source)
        ).to be true
      end
    end

    context 'when the target is not on the same row or column as the source' do
      let(:source) { [7, 2] }
      let(:target) { [4, 3] }

      it 'returns false' do
        expect(
          piece.same_row_or_column?(target, source)
        ).to be false
      end
    end
  end

  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:piece) { described_class.new(true) }

    let(:source) { [4, 4] }

    before do
      board.update(source[0], source[1], piece)
      board.update(3, 4, described_class.new(true))
      board.update(7, 4, described_class.new(false))
    end

    context 'when rook tries an invalid move' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [5, 0], board)).to be false
      end
    end

    context 'when rook tries to leap' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [2, 4], board)).to be false
      end
    end

    context 'when rook tries an valid move (i)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [6, 4], board)).to be true
      end
    end

    context 'when rook tries an valid move (ii)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [4, 7], board)).to be true
      end
    end

    context 'when white rook tries try to capture a white piece' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [3, 4], board)).to be false
      end
    end

    context 'when white rook tries try to capture a black piece' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [5, 4], board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
