require '../input_reader'

def format_input
  InputReader.read.map { |s| s.chars.map(&:to_i) }
end

def get_lookup_coords(direction, grid, row, col)
  case direction
  when 'N'
    (0..(row - 1)).to_a.reverse.map { |r| [r, col] }
  when 'S'
    ((row + 1)..(grid.size - 1)).to_a.map { |r| [r, col] }
  when 'W'
    (0..(col - 1)).to_a.reverse.map { |c| [row, c] }
  when 'E'
    ((col + 1)..(grid[0].size - 1)).to_a.map { |c| [row, c] }
  end
end

def edge?(grid, row, col)
  [0, grid.size - 1].include?(row) || [0, grid[0].size - 1].include?(col)
end

def visible?(grid, tree, row, col)
  return true if edge?(grid, row, col)

  visible = false
  %w[N W S E].each do |direction|
    visible = get_lookup_coords(direction, grid, row, col).all? { |row, col| grid[row][col] < tree }

    break if visible
  end

  visible
end

def part1(grid)
  visible = 0

  grid.each_with_index do |row, row_index|
    row.each_with_index do |tree, column_index|
      visible += 1 if visible?(grid, tree, row_index, column_index)
    end
  end

  visible
end

def get_scenic_score(grid, tree, row, col)
  return 0 if edge?(grid, row, col)

  direction_count = []

  %w[N W S E].map do |direction|
    count = 0

    get_lookup_coords(direction, grid, row, col).each do |row, col|
      count += 1
      break if grid[row][col] >= tree
    end

    direction_count.push(count)
  end

  direction_count.reject(&:zero?).inject(:*)
end

def part2(grid)
  highest_scenic = 0

  grid.each_with_index do |row, row_index|
    row.each_with_index do |tree, column_index|
      highest_scenic = [highest_scenic, get_scenic_score(grid, tree, row_index, column_index)].compact.max
    end
  end

  highest_scenic
end

puts part1(format_input)
puts part2(format_input)
