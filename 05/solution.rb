require '../input_reader'

def format_input
  stack_data, moves = InputReader.read.slice_after('').to_a
  stack_number = stack_data[-2][-1].to_i
  stacks = stack_data[..-3]
  indexes = Array.new(stack_number) { |i| (i * 4) + 1 }

  [
    stacks.map { |s| s.chars.values_at(*indexes).map { |s| s == ' ' ? nil : s } }.transpose.map(&:compact),
    moves.map { |m| m.match(/move ([0-9]*) from ([0-9]*) to ([0-9]*)/)[1..].map(&:to_i) }
  ]
end

def part1(formatted_input)
  stacks, moves = formatted_input
  moves.each { |move, from, to| move.times { stacks[to - 1].unshift(stacks[from - 1].shift) } }
  stacks.map(&:first).join
end

def part2(formatted_input)
  stacks, moves = formatted_input
  moves.each { |move, from, to| stacks[to - 1].unshift(*stacks[from - 1].shift(move)) }
  stacks.map(&:first).join
end

puts part1(format_input)
puts part2(format_input)
