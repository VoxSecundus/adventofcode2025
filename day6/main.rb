# frozen_string_literal: true

require 'matrix'

def part_one(input)
  matrix = input.split("\n").map(&:split).transpose

  sum = 0

  matrix.each do |series|
    operator = series.pop.to_sym

    initial = case operator
              when :*
                1
              when :+
                0
              else
                raise 'Unrecognised operator'
              end

    val = series.inject(initial) { |total, n| total.public_send(operator.to_sym, n.to_i) }

    sum += val
  end

  sum
end

def part_two(input)
  rows = input.split("\n")

  operators = rows.pop.split.reject(&:empty?).map(&:to_sym)

  raw_matrix = rows.map(&:chars)

  row_limit = raw_matrix.map(&:size).max

  raw_matrix.select { |r| r.size < row_limit }.each { |r| r << ' ' }

  matrix = Matrix.rows(raw_matrix).transpose

  new_rows = matrix.to_a.map { |r| r.join.strip }

  operations = [Array.new]
  index = 0

  new_rows.each do |inp|
    if inp == ''
      operations << []
      index += 1
      next
    end

    operations[index] << inp
  end

  total = 0
  operators.length.times do |idx|
    operator = operators[idx]

    initial = case operator
              when :*
                1
              when :+
                0
              else
                raise 'Unrecognised operator'
              end

    total += operations[idx].inject(initial) { |total, n| total.public_send(operator.to_sym, n.to_i) }
  end
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
