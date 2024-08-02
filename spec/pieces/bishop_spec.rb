# frozen_string_literal: true

require './lib/board'
require './lib/pieces/bishop'

# rubocop:disable Metrics/BlockLength
describe Bishop do
  subject(:piece) { described_class.new(true) }

  describe '#same_diagonal?' do
    context 'when the target is on the same diagonal as the source' do
      let(:source) { [7, 2] }
      let(:target) { [5, 0] }

      it 'returns true' do
        expect(
          piece.same_diagonal?(target, source)
        ).to be true
      end
    end

    context 'when the target is not on the same diagonal as the source' do
      let(:source) { [7, 2] }
      let(:target) { [4, 2] }

      it 'returns false' do
        expect(
          piece.same_diagonal?(target, source)
        ).to be false
      end
    end
  end

  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:source) { [7, 2] }
    let(:invalid_target_one) { [5, 1] }
    let(:invalid_target_two) { [7, 0] }
    let(:valid_target) { [5, 4] }

    before do
      board.default_state
    end
    context 'when bishop tries an invalid move' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_one, board)).to be false
      end
    end

    context 'when bishop tries to leap' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_one, board)).to be false
      end
    end

    context 'when bishop tries an valid move' do
      before do
        board.update(6, 3, '    ')
      end
      it 'returns true' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, valid_target, board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
