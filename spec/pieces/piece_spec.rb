# frozen_string_literal: true

require './lib/board'
require './lib/pieces/piece'

# rubocop:disable Metrics/BlockLength
describe Piece do
  subject(:piece) { described_class.new(true, 'SYMBOL') }
  let(:board) { instance_double(Board) }

  describe '#update' do
    it 'increases n_movements by 1' do
      expect { piece.update }.to change { piece.n_movements }.by(1)
    end

    it 'increases n_movements up to 4' do
      3.times { piece.update }
      expect { piece.update }.to change { piece.n_movements }.to(4)
    end
  end

  describe '#same_player?' do
    context 'when target is empty' do
      before do
        allow(board).to receive(:empty?).and_return(true)
      end
      it 'returns false' do
        expect(piece.same_player?([5, 5], board)).to be false
      end
    end

    context 'when target does not belong to the same player' do
      before do
        allow(board).to receive(:empty?).and_return(false)
        allow(board).to receive(:this_piece_white?).and_return(false)
      end
      it 'returns false' do
        expect(piece.same_player?([5, 5], board)).to be false
      end
    end

    context 'when the target belongs to the same player' do
      before do
        allow(board).to receive(:empty?).and_return(false)
        allow(board).to receive(:this_piece_white?).and_return(true)
      end
      it 'returns true' do
        expect(piece.same_player?([5, 5], board)).to be true
      end
    end
  end

  describe '#valid_movement?' do
    context 'when the target belongs to the same player' do
      before do
        allow(piece).to receive(:same_player?).and_return(true)
      end
      it 'returns false' do
        expect(piece.valid_movement?([0, 0], [1, 0], board)).to be false
      end
    end

    context 'when source equals to target' do
      before do
        allow(piece).to receive(:same_player?).and_return(false)
      end
      it 'returns false' do
        expect(piece.valid_movement?([0, 0], [0, 0], board)).to be false
      end
    end

    context 'when the target does not belong to the same player and source != target' do
      before do
        allow(piece).to receive(:same_player?).and_return(false)
      end
      it 'returns true' do
        expect(piece.valid_movement?([0, 0], [0, 1], board)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
