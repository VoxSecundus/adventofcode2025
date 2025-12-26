# frozen_string_literal

PAPER = '@'

OFFSETS = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
]

def part_one(input)
  rows = input.split("\n").map { |r| r.split('') }
  reference = input.split("\n").map { |r| r.split('') }

  total_rolls = 0

  height = rows.size
  width = rows.first.size

  height.times do |i|
    width.times do |j|
      current = rows[i][j]
      next unless current == PAPER

      count = 0

      OFFSETS.each do |offset|
        # Row boundary
        next if offset[0] == -1 && i == 0
        next if offset[0] == 1 && i == height - 1

        # Column boundary
        next if offset[1] == -1 && j == 0
        next if offset[1] == 1 && j == width -1

        val = rows[i + offset[0]][j + offset[1]]  
        count += 1 if val == PAPER
      end

      total_rolls += 1 if count < 4
      reference[i][j] = 'x' if count < 4
    end
  end

  total_rolls
end

def part_two(input)
  rows = input.split("\n").map { |r| r.split('') }

  new = remove_rolls(rows)[:new]

  while true
    result = remove_rolls(new)
    new = result[:new]

    break if result[:changed] == 0
  end

  rows.flatten.count('x')
end

def remove_rolls(rows)
  # WIP
  height = rows.size
  width = rows.first.size

  total_count = 0

  height.times do |i|
    width.times do |j|
      current = rows[i][j]
      next unless current == PAPER

      count = 0

      OFFSETS.each do |offset|
        # Row boundary
        next if offset[0] == -1 && i == 0
        next if offset[0] == 1 && i == height - 1

        # Column boundary
        next if offset[1] == -1 && j == 0
        next if offset[1] == 1 && j == width -1

        val = rows[i + offset[0]][j + offset[1]]  
        count += 1 if val == PAPER
      end

      if count < 4
        rows[i][j] = 'x' 
        total_count += 1
      end
    end
  end

  {new: rows, changed: total_count}

end

input = File.read(File.join(File.dirname(__FILE__), 'input'))
example = File.read(File.join(File.dirname(__FILE__), 'example'))

puts <<~HEREDOC
  Example:
  #{part_one(example)}
  #{part_two(example)}

  Solution:
  #{part_one(input)}
  #{part_two(input)}
HEREDOC
