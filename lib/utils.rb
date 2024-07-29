# frozen_string_literal: true

def get_coordinates(pos, size = 8)
  [parse_rank(pos[1], size), parse_file(pos[0])]
end

def parse_file(char)
  char.downcase.ord - 97
end

def parse_rank(char, size = 8)
  size - char.to_i
end
