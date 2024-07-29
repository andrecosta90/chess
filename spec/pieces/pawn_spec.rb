# frozen_string_literal: true

require './lib/board'
require './lib/pieces/pawn'

# rubocop:disable Metrics/BlockLength
describe Pawn do
  describe '#movable_items' do
    context 'when the pawn has not moved yet' do
      let(:white_piece) { described_class.new(true) }
      let(:black_piece) { described_class.new(false) }
      let(:x) { 4 }
      let(:y) { 3 }

      it 'is allowed to move up to two squares (white piece)' do
        expect(white_piece.movable_items([x, y])).to eql([
                                                           [
                                                             x + white_piece.additive_factor, y
                                                           ],
                                                           [
                                                             x + white_piece.additive_factor * 2, y
                                                           ]
                                                         ])
      end
      it 'is allowed to move up to two squares (black piece)' do
        expect(black_piece.movable_items([x, y])).to eql([
                                                           [
                                                             x + black_piece.additive_factor, y
                                                           ],
                                                           [x + black_piece.additive_factor * 2, y]
                                                         ])
      end
    end
    context 'when the pawn has already moved' do
      let(:piece) { described_class.new(true) }
      let(:x) { 5 }
      let(:y) { 6 }
      it 'is allowed to move only one square' do
        piece.update
        expect(piece.movable_items([x, y])).to eql([
                                                     [x + piece.additive_factor, y]
                                                   ])
      end
    end

    context 'when there is no more square for the pawn to move' do
      let(:piece) { described_class.new(true) }
      let(:x) { 0 }
      let(:y) { 3 }
      it 'returns an empty array' do
        expect(piece.movable_items([x, y])).to eql([])
      end
    end
  end

  describe '#capturable_items' do
    context 'when the pawn can capture in both diagonals' do
      let(:white_piece) { described_class.new(true) }
      let(:black_piece) { described_class.new(true) }
      let(:x) { 6 }
      let(:y) { 1 }
      it 'returns two items (white piece)' do
        expect(white_piece.capturable_items([x, y])).to eql(
          [[x + white_piece.additive_factor, y + 1],
           [x + white_piece.additive_factor, y - 1]]
        )
      end

      it 'returns two items (black piece)' do
        expect(black_piece.capturable_items([x, y])).to eql(
          [[x + black_piece.additive_factor, y + 1],
           [x + black_piece.additive_factor, y - 1]]
        )
      end
    end

    context 'when the pawn can capture on only one diagonal' do
      let(:piece) { described_class.new(true) }
      let(:x) { 6 }
      let(:y_left) { 0 }
      let(:y_right) { 7 }
      it 'returns one item (left)' do
        expect(piece.capturable_items([x, y_left])).to eql(
          [[x + piece.additive_factor, y_left + 1]]
        )
      end

      it 'returns one item (right)' do
        expect(piece.capturable_items([x, y_right])).to eql(
          [[x + piece.additive_factor, y_right - 1]]
        )
      end
    end

    context 'when the pawn is not able to capture' do
      let(:white_piece) { described_class.new(true) }
      let(:black_piece) { described_class.new(false) }
      it 'returns an empty array (white)' do
        expect(white_piece.capturable_items([0, 0])).to eql(
          []
        )
      end

      it 'returns an empty array (black)' do
        expect(black_piece.capturable_items([7, 7])).to eql(
          []
        )
      end
    end
  end

  describe '#valid_movement?' do
    let(:board) { Board.new }
    let(:source) { [6, 3] }
    let(:invalid_target) { [3, 3] }
    let(:valid_target) { [4, 3] }

    context 'when pawn tries an invalid move' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, invalid_target, board)).to be false
      end
    end

    context 'when the pawn tries to move two squares again' do
      it 'returns false' do
        piece = board.select_piece_from(source)
        piece.update
        expect(piece.valid_movement?(source, valid_target, board)).to be false
      end
    end

    context 'when pawn tries an valid move' do
      it 'returns true' do
        piece = board.select_piece_from(source)
        expect(piece.valid_movement?(source, valid_target, board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
