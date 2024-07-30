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
    let(:source) { [7, 0] }
    let(:invalid_target_one) { [5, 0] }
    let(:invalid_target_two) { [5, 1] }
    let(:valid_target) { [7, 1] }
    context 'when rook tries an invalid move' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_one, board)).to be false
      end
    end

    context 'when rook tries to leap' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_one, board)).to be false
      end
    end

    context 'when rook tries an valid move' do
      it 'returns true' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, valid_target, board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
