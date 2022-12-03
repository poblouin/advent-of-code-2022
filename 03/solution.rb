require '../input_reader'

def format_input
  InputReader.read
end

def compute_priority(common)
  common =~ /[A-Z]/ ? common.ord - 38 : common.ord - 96
end

def part1(formatted_input)
  formatted_input.sum do |e|
    first, second = e.partition(/.{#{e.size / 2}}/)[1, 2]
    compute_priority((first.chars & second.chars).first)
  end
end

def part2(formatted_input)
  formatted_input.each_slice(3).sum do |first, second, third|
    compute_priority((first.chars & second.chars & third.chars).first)
  end
end

puts part1(format_input)
puts part2(format_input)
