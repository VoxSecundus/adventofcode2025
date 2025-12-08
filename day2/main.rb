# frozen_string_literal: true

def ranges_from_input(input)
  input.split(',').map { |str| Range.new(*str.split('-').map(&:to_i)) }
end

def each_id(input, &block)
  ranges_from_input(input).each do |range|
    range.each(&block)
  end
end

def part_one(input)
  invalid_ids = []

  each_id(input) do |id|
    digits = id.digits
    next if digits.length.odd?

    pivot = digits.length / 2

    invalid_ids << id.to_i if digits[...pivot] == digits[pivot..]
  end
  invalid_ids.sum
end

def part_two(input)
  invalid_ids = []

  each_id(input) do |id|
    factors = get_factors(id.digits.length)

    chunks = factors.map { |f| id.digits.each_slice(f).to_a }

    invalid_ids << id if chunks.any? { |chunk| chunk.uniq.length == 1 }
  end

  invalid_ids.sum
end

def get_factors(number)
  (1..number).select { |i| (number % i).zero? } - [number]
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
