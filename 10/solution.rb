require '../input_reader'

def format_input
  InputReader.read
end

def part1(formatted_input)
  cycle = 0
  x = 1
  signal = []

  formatted_input.map(&:split).each do |op, value|
    2.times do
      cycle += 1
      signal.push(cycle * x) if cycle % 40 == 20

      break if op == 'noop'
    end

    x += value.to_i
  end

  signal.sum
end

def part2(formatted_input)
  cycle = 0
  x = 1
  pixels = Array.new(6) { [] }

  formatted_input.map(&:split).each do |op, value|
    sprite = (x - 1..x + 1).to_a

    2.times do
      cycle += 1

      line = (cycle - 1) / 40
      draw_index = (cycle - 1) % 40
      pixels[line][draw_index] = sprite.include?(draw_index) ? '#' : '.'

      break if op == 'noop'
    end

    break if cycle >= 240

    x += value.to_i
  end

  pixels.each { |line| puts line.join }
end

puts part1(format_input)
part2(format_input)
