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

end
# rubocop:enable Metrics/BlockLength
