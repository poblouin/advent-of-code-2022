require 'set'
require '../input_reader'

def format_input
  InputReader.read.first
end

def find_marker(offset, input)
  input.chars.each_cons(offset).take_while { |chuck| Set.new(chuck).size != offset }.count + offset
end

def part1(formatted_input)
  find_marker(4, formatted_input)
end

def part2(formatted_input)
  find_marker(14, formatted_input)
end

puts part1(format_input)
puts part2(format_input)
