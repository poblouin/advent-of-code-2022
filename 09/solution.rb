require '../input_reader'

def format_input
  InputReader.read.map(&:split)
end

def adjacent?(head, tail)
  ((tail[0] - head[0]).abs <= 1 && (tail[1] - head[1]).abs <= 1) || (head[0] == tail[0] && head[1] == tail[1])
end

def move(head, tail)
  return if adjacent?(head, tail)

  delta_x = head[0] - tail[0]
  delta_y = head[1] - tail[1]
  delta_x /= 2 if delta_x.abs == 2
  delta_y /= 2 if delta_y.abs == 2

  tail[0] += delta_x
  tail[1] += delta_y
end

def part1(formatted_input)
  knots = Array.new(2) { [1000, 1000] }
  visited = []

  formatted_input.each do |direction, step_count|
    step_count.to_i.times do
      case direction
      when 'U'
        knots.first[1] += 1
      when 'L'
        knots.first[0] -= 1
      when 'D'
        knots.first[1] -= 1
      when 'R'
        knots.first[0] += 1
      end

      move(knots.first, knots.last)
      visited.push(knots.last.join)
    end
  end

  visited.uniq.size
end

def part2(formatted_input)
  knots = Array.new(10) { [1000, 1000] }
  visited = []

  formatted_input.each do |direction, step_count|
    step_count.to_i.times do
      case direction
      when 'U'
        knots.first[1] += 1
      when 'L'
        knots.first[0] -= 1
      when 'D'
        knots.first[1] -= 1
      when 'R'
        knots.first[0] += 1
      end

      knots.each_cons(2) do |previous, current|
        move(previous, current)
      end
      visited.push(knots.last.join)
    end
  end

  visited.uniq.size
end

puts part1(format_input)
puts part2(format_input)
