require '../input_reader'

def format_input
  InputReader.read.map(&:to_i).slice_before(&:zero?).to_a.map(&:sum)
end

def part1(formatted_input)
  formatted_input.max
end

def part2(formatted_input)
  formatted_input.max(3).sum
end

puts part1(format_input)
puts part2(format_input)
