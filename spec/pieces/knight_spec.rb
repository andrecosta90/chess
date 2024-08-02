# frozen_string_literal: true

require './lib/board'
require './lib/pieces/knight'

# rubocop:disable Metrics/BlockLength
describe Knight do
  subject(:piece) { described_class.new(true) }
  describe '#movable_items' do
    context 'when the knight is in the center' do
      let(:x) { 3 }
      let(:y) { 3 }

      it 'returns all possible candidates' do
        expect(
          piece.movable_items([x, y])
        ).to eql([[1, 2], [1, 4], [2, 1], [2, 5], [4, 1], [4, 5], [5, 2], [5, 4]])
      end
    end

    context 'when the knight is in top right corner' do
      let(:x) { 0 }
      let(:y) { 7 }

      it 'returns candidates' do
        expect(
          piece.movable_items([x, y])
        ).to eql([[1, 5], [2, 6]])
      end
    end

    context 'when the knight is in botton left corner' do
      let(:x) { 7 }
      let(:y) { 0 }

      it 'returns candidates' do
        expect(
          piece.movable_items([x, y])
        ).to eql([[5, 1], [6, 2]])
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
      board.update(2, 4, described_class.new(true))
      board.update(4, 3, described_class.new(true))
      board.update(2, 3, described_class.new(true))
      board.update(5, 6, described_class.new(false))
    end

    context 'when knight tries an invalid move' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [3, 1], board)).to be false
      end
    end

    context 'when knight tries an valid move' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [3, 2], board)).to be true
      end
    end

    context 'when knight tries to leap' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [2, 5], board)).to be true
      end
    end

    context 'when white knight tries try to capture a white piece' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [2, 3], board)).to be false
      end
    end

    context 'when white knight tries try to capture a black piece' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [5, 6], board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
