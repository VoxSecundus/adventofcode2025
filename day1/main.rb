# frozen_string_literal: true

DIRECTIONAL_OPERATORS = {
  'L' => :-,
  'R' => :+
}.freeze

def part_one(input)
  start = 50
  zero_count = 0

  input.each do |instruction|
    distance = instruction[1..].to_i
    direction = DIRECTIONAL_OPERATORS[instruction[0]]
    start = start.send(direction, distance) % 100

    zero_count += 1 if start.zero?
  end

  zero_count
end

def part_two(input)
  start = 50
  zero_count = 0

  input.each do |instruction|
    distance = instruction[1..].to_i
    direction = DIRECTIONAL_OPERATORS[instruction[0]]

    zero_count += wrap_count(start, distance, direction)
    start = start.send(direction, distance) % 100
  end

  zero_count
end

def wrap_count(start, distance, direction)
  if direction == :+
    (start + distance) / 100
  else
    val = (distance - start) / 100
    start.zero? ? val : val + 1
  end
end

input_arr = File.read(File.join(File.dirname(__FILE__), 'input')).split("\n")
example_arr = File.read(File.join(File.dirname(__FILE__), 'example')).split("\n")

puts <<~HEREDOC
  Example:
  #{part_one(example_arr)}
  #{part_two(example_arr)}


  Solution:
  #{part_one(input_arr)}
  #{part_two(input_arr)}
HEREDOC
