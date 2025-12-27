# frozen_string_literal: true

def part_one(input)
  ranges = []
  available = []

  input.split("\n\n").tap do |fresh, available_str|
    # Build ranges
    fresh.split("\n").each do |str|
      ranges << Range.new(*str.split('-').map(&:to_i))
    end

    # Build available IDs
    available = available_str.split("\n").map(&:to_i)
  end

  fresh_count = 0

  available.each do |a|
    fresh_count += 1 if ranges.any? { |r| r.cover?(a) }
  end

  fresh_count
end

def part_two(input)
  ranges = []

  input.split("\n\n").tap do |fresh, _|
    # Build ranges
    fresh.split("\n").each do |str|
      ranges << Range.new(*str.split('-').map(&:to_i))
    end
  end

  ranges.sort_by!(&:begin)
  checked_ranges = []

  ranges.each do |range|
    if checked_ranges.last&.overlap?(range)
      new_begin = checked_ranges.last.begin
      new_end = [range.end, checked_ranges.last.end].max
      checked_ranges.pop
      checked_ranges << Range.new(new_begin, new_end)
    else
      checked_ranges << range
    end
  end

  total = 0
  checked_ranges.each { |r| total += r.size }

  total
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
