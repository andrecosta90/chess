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
    let(:pawn1) { described_class.new(true) }
    let(:pawn2) { described_class.new(true) }

    let(:source1) { [4, 3] }
    let(:source2) { [4, 6] }

    before do
      board.update(source1[0], source1[1], pawn1)
      board.update(source2[0], source2[1], pawn2)
      board.update(3, 6, described_class.new(false))
      board.update(3, 7, described_class.new(false))
    end

    context 'when pawn tries an invalid move' do
      it 'returns false (i)' do
        expect(pawn1.valid_movement?(source1, [5, 4], board)).to be false
      end

      it 'returns false (ii)' do
        expect(pawn1.valid_movement?(source1, [3, 7], board)).to be false
      end
    end

    context 'when the pawn tries to move two squares again' do
      it 'returns false' do
        pawn1.update
        expect(pawn1.valid_movement?(source1, [2, 3], board)).to be false
      end
    end

    context 'when pawn tries to leap' do
      it 'returns false' do
        expect(pawn2.valid_movement?(source2, [2, 6], board)).to be false
      end
    end

    context 'when pawn tries an valid move (i)' do
      it 'returns true' do
        expect(pawn1.valid_movement?(source1, [2, 3], board)).to be true
      end
    end

    context 'when pawn tries a straight capture' do
      it 'returns false' do
        expect(pawn2.valid_movement?(source2, [3, 6], board)).to be false
      end
    end

    context 'when pawn tries a diagonal capture' do
      it 'returns true' do
        expect(pawn2.valid_movement?(source2, [3, 7], board)).to be true
      end
    end

    context 'when white pawn tries try to capture a white piece' do
      it 'returns false' do
        expect(pawn2.valid_movement?(source2, [3, 5], board)).to be false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
