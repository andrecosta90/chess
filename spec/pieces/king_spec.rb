# frozen_string_literal: true

require './lib/board'
require './lib/pieces/king'

# rubocop:disable Metrics/BlockLength
describe King do
  subject(:piece) { described_class.new(true) }
  describe '#movable_items' do
    context 'when the king is in the center' do
      let(:x) { 3 }
      let(:y) { 3 }

      it 'returns all possible candidates' do
        expect(
          piece.movable_items([x, y])
        ).to eql([[2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4]])
      end
    end

    context 'when the king is in top right corner' do
      let(:x) { 0 }
      let(:y) { 7 }

      it 'returns candidates' do
        expect(
          piece.movable_items([x, y])
        ).to eql([[0, 6], [1, 6], [1, 7]])
      end
    end

    context 'when the knight is in botton left corner' do
      let(:x) { 7 }
      let(:y) { 0 }

      it 'returns candidates' do
        expect(
          piece.movable_items([x, y])
        ).to eql([[6, 0], [6, 1], [7, 1]])
      end
    end
  end

  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:source) { [7, 4] }
    let(:invalid_target_one) { [6, 4] }
    let(:invalid_target_two) { [5, 2] }
    let(:valid_target) { [6, 5] }

    before do
      board.default_state
    end

    context 'when king tries an invalid move' do
      before do
        board.update(6, 3, '    ')
      end
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_one, board)).to be false
      end
    end

    context 'when king tries to leap' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target_two, board)).to be false
      end
    end

    context 'when king tries an valid move' do
      before do
        board.update(valid_target[0], valid_target[1], '    ')
      end
      it 'returns true' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, valid_target, board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
