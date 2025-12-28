# frozen_string_literal: true

def part_one(input)
  splits = 0

  raw_matrix = input.split("\n").map(&:chars)

  raw_matrix.each_with_index do |row, x|
    row.each_with_index do |col, y|
      if col == 'S' # Start coordinate
        raw_matrix[x + 1][y] = '|'
      elsif col == '.' && raw_matrix[x - 1][y] == '|' # Propagate beam
        raw_matrix[x][y] = '|'
      elsif col == '^' && raw_matrix[x - 1][y] == '|' # Split beam
        splits += 1

        # Split to left side
        raw_matrix[x][y - 1] = '|'

        # Split to right side unless it would already become a beam from above
        raw_matrix[x][y + 1] = '|' if raw_matrix[x][y + 1] != '|' && raw_matrix[x - 1][y + 1] != '|'
      end
    end
  end

  splits
end

def part_two(input)

end

input = File.read(File.join(File.dirname(__FILE__), 'input'))
example = File.read(File.join(File.dirname(__FILE__), 'example'))

puts <<~HEREDOC
  Example:
  #{part_one(example)}
  #{part_two(example)}

  Solution:
  #{part_one(input)}
  {part_two(input)}
HEREDOC
