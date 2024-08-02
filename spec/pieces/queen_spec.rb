# frozen_string_literal: true

require './lib/board'

# rubocop:disable Metrics/BlockLength
describe Queen do
  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:source) { [7, 3] }
    let(:invalid_target_one) { [6, 1] }
    let(:invalid_target_two) { [5, 2] }
    let(:valid_target) { [5, 1] }

    before do
      board.default_state
    end

    context 'when queen tries an invalid move' do
      before do
        board.update(6, 1, '    ')
        board.update(6, 2, '    ')
      end
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_one, board)).to be false
      end
    end

    context 'when queen tries to leap' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_two, board)).to be false
      end
    end

    context 'when queen tries a valid move' do
      before do
        board.update(6, 2, '    ')
      end
      it 'returns true' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, valid_target, board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
