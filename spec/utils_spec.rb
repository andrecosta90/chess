# frozen_string_literal: true

require './lib/utils'

# rubocop:disable Metrics/BlockLength
describe 'utils module' do
  describe '#parse_rank' do
    it 'when char = "8", it returns 0' do
      expect(parse_rank('8')).to eq(0)
    end

    it 'when char = "5", it returns 3' do
      expect(parse_rank('5')).to eq(3)
    end

    it 'when char = "1", it returns 7' do
      expect(parse_rank('1')).to eq(7)
    end
  end

  describe '#parse_file' do
    it 'when char = "a", it returns 0' do
      expect(parse_file('a')).to eq(0)
    end

    it 'when char = "d", it returns 3' do
      expect(parse_file('d')).to eq(3)
    end

    it 'when char = "g", it returns 6' do
      expect(parse_file('g')).to eq(6)
    end
  end

  describe '#get_coordinates' do
    it 'when pos = "b5", it returns [3, 1]' do
      expect(get_coordinates('b5')).to eq([3, 1])
    end

    it 'when pos = "e4", it returns [4, 4]' do
      expect(get_coordinates('e4')).to eq([4, 4])
    end

    it 'when pos = "h1", it returns [7, 7]' do
      expect(get_coordinates('h1')).to eq([7, 7])
    end
  end
end
# rubocop:enable Metrics/BlockLength
