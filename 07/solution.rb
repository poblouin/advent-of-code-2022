require '../input_reader'

def format_input
  InputReader.read
end

def compute_sizes(input, fs)
  input.each_with_object([]) do |command, memo|
    if command.start_with?('$ cd')
      cd_dir = command.match(/\$ cd (.*)/)[1]
      if cd_dir == '..'
        memo.pop
      else
        memo.push [memo.last, cd_dir].compact.join('--')
      end
    elsif command.match(/^\d+/)
      size = command.match(/^\d+/)[0].to_i
      memo.each { |path| fs[path] += size }
    end
  end
end

def solve(formatted_input)
  fs = Hash.new(0)
  compute_sizes(formatted_input, fs)

  puts part1(fs)
  puts part2(fs)
end

def part1(fs)
  fs.values.reject { |path| path > 100_000 }.sum
end

def part2(fs)
  root = fs['/']

  fs.values.reject { |path| path < root - 40_000_000 }.min
end

solve(format_input)
