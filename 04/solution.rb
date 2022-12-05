require '../input_reader'

def format_input
  InputReader.read.map { |s| s.split(',').map { |e| (e.split('-')[0]..e.split('-')[1]).to_a.map(&:to_i) } }
end

def part1(formatted_input)
  formatted_input.sum { |e| e.include?(e[0] & e[1]) ? 1 : 0 }
end

def part2(formatted_input)
  formatted_input.each_slice(2).sum { |pair| pair.sum { |e| (e[0] & e[1]).empty? ? 0 : 1 } }
end

puts part1(format_input)
puts part2(format_input)
