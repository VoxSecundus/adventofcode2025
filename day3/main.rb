# frozen_string_literal

def part_one(input)
  max_jolts = []
  banks = input.split("\n")

  banks.each do |bank|
    first_max = -1
    second_max = -1

    loop_arr = bank.each_char.to_a
    until loop_arr.empty?
      val = loop_arr.shift.to_i
      if val > first_max && !loop_arr.empty?
        first_max = val
        second_max = -1
      elsif val > second_max
        second_max = val
      end
    end

    max_jolts << (first_max.to_s + second_max.to_s).to_i
  end

  max_jolts.sum
end

def part_two(input)
  max_jolts = []
  banks = input.split("\n")

  banks.each do |bank|
    puts bank.reverse
  end

  max_jolts.sum
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
