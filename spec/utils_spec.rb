# frozen_string_literal: true

require './lib/utils'

# rubocop:disable Metrics/BlockLength
describe Utils do
  describe '.parse_rank' do
    {
      '8' => 0,
      '5' => 3,
      '1' => 7
    }.each do |input, expected_output|
      it "returns #{expected_output} when char = \"#{input}\"" do
        expect(Utils.parse_rank(input)).to eq(expected_output)
      end
    end
  end

  describe '.parse_file' do
    {
      'a' => 0,
      'd' => 3,
      'g' => 6
    }.each do |input, expected_output|
      it "returns #{expected_output} when char = \"#{input}\"" do
        expect(Utils.parse_file(input)).to eq(expected_output)
      end
    end
  end

  describe '.get_coordinates' do
    {
      'b5' => [3, 1],
      'e4' => [4, 4],
      'h1' => [7, 7]
    }.each do |input, expected_output|
      it "returns #{expected_output} when pos = \"#{input}\"" do
        expect(Utils.get_coordinates(input)).to eq(expected_output)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
