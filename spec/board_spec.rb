# frozen_string_literal: true

require './lib/board'
require './lib/player'
require './lib/pieces/piece'

# rubocop:disable Metrics/BlockLength
describe Board do
  subject(:board) { described_class.new }
  let(:player) { instance_double(Player) }
  let(:piece) { instance_double(Piece) }

  describe '#update' do
    it 'will update grid matrix value' do
      expect { board.update(0, 0, 'PIECE') }.to change { board.grid[0][0] }.to('PIECE')
    end

    it 'will return PIECE as captured value ' do
      board.update(0, 0, 'PIECE')
      captured = board.update(0, 0, 'OTHER_PIECE')
      expect(captured).to eq('PIECE')
    end
  end

  describe '#path_free?' do
    it 'returns true if path is free' do
      expect(board.path_free?([[2, 2], [2, 3], [2, 4]])).to be true
    end

    it 'returns false if path is not free' do
      expect(board.path_free?([[0, 0], [1, 0], [2, 0], [3, 0]])).to be false
    end
  end

  describe '#execute_move' do
    context 'when there is no capture' do
      let(:object) do
        { source: [6, 0], target: [6, 0] }
      end
      before do
        allow(piece).to receive(:update)
      end
      it 'returns false' do
        expect(board.execute_move(object, piece, player)).to be false
      end
    end

    context 'when there is a capture' do
      let(:object) do
        { source: [6, 0], target: [1, 0] }
      end
      before do
        allow(piece).to receive(:update)
        allow(player).to receive(:capture)
        allow(player).to receive(:white?)
      end
      it 'returns true' do
        expect(board.execute_move(object, piece, player)).to be true
      end
    end
  end

  describe '#validate_move' do
    context 'when there is no piece in the source position' do
      let(:object) do
        { source: [3, 3], target: [3, 4] }
      end
      it 'raises an exception' do
        expect do
          board.validate_move(object, nil, nil)
        end.to raise_error(StandardError, 'Invalid move -- There is no piece in this position!')
      end
    end

    context 'when the white player tries to move a black piece' do
      let(:object) do
        { source: [1, 0], target: [2, 0] }
      end

      before do
        allow(player).to receive(:white?).and_return(true)
        allow(piece).to receive(:white?).and_return(false)
      end

      it 'raises an exception' do
        expect do
          board.validate_move(object, piece,
                              player)
        end.to raise_error(StandardError, "Invalid move -- #{player} can't move this piece!")
      end
    end

    context 'when the white player tries an invalid move' do
      let(:object) do
        { source: [6, 0], target: [4, 0] }
      end

      before do
        allow(player).to receive(:white?).and_return(true)
        allow(piece).to receive(:white?).and_return(true)
        allow(piece).to receive(:valid_movement?).and_return(false)
      end

      it 'raises an exception' do
        expect do
          board.validate_move(object, piece,
                              player)
        end.to raise_error(StandardError, "Invalid movement -- You can't move to this position!")
      end
    end

    context 'when the white player makes a valid move' do
      let(:object) do
        { source: [6, 0], target: [4, 0] }
      end

      before do
        allow(player).to receive(:white?).and_return(true)
        allow(piece).to receive(:white?).and_return(true)
        allow(piece).to receive(:valid_movement?).and_return(true)
      end

      it 'returns true' do
        expect(board.validate_move(object, piece, player)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength