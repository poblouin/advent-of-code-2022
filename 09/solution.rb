require '../input_reader'

NEIGHBORS = [[0, 0], [-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

def format_input
  InputReader.read.map(&:split)
end

def adjacent?(head, tail)
  NEIGHBORS.map { |x, y| [head[0] + x, head[1] + y] }.include?(tail)
end

def move_tail(head, tail)
  NEIGHBORS.map { |x, y| [tail[0] + x, tail[1] + y] }.find { |new_tail| adjacent?(head, new_tail) && (new_tail[0] == head[0] || new_tail[1] == head[1]) }
end

def part1(formatted_input)
  head = [10000, 10000]
  tail = [10000, 10000]
  visited = [[10000, 10000]]

  formatted_input.each do |direction, step_count|
    step_count.to_i.times do
      case direction
      when 'U'
        head[1] += 1
      when 'L'
        head[0] -= 1
      when 'D'
        head[1] -= 1
      when 'R'
        head[0] += 1
      end

      tail = visited.push(adjacent?(head, tail) ? tail : move_tail(head, tail)).last
    end
  end

  visited.map(&:join).uniq.size
end

puts part1(format_input)
