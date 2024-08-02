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
    let(:piece) { described_class.new(true) }

    let(:source) { [4, 4] }

    before do
      board.update(source[0], source[1], piece)
      board.update(3, 3, described_class.new(true))
      board.update(7, 7, described_class.new(false))
      board.update(1, 7, described_class.new(true))
    end
    context 'when bishop tries an invalid move' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [6, 4], board)).to be false
      end
    end

    context 'when bishop tries to leap' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [2, 2], board)).to be false
      end
    end

    context 'when bishop tries an valid move (i)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [2, 6], board)).to be true
      end
    end

    context 'when bishop tries an valid move (ii)' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [7, 1], board)).to be true
      end
    end

    context 'when bishop tries a capture' do
      it 'returns true' do
        expect(piece.valid_movement?(source, [7, 7], board)).to be true
      end
    end

    context 'when white bishop tries try to capture a white piece' do
      it 'returns false' do
        expect(piece.valid_movement?(source, [1, 7], board)).to be false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
