require '../input_reader'

CHOICE_SCORES = {
  'A' => 1,
  'B' => 2,
  'C' => 3,
}
WIN = ['AB', 'BC', 'CA']
LOSS = ['AC', 'BA', 'CB']

def format_input
  InputReader.read.map { |s| s.delete(' ') }
end

def compute_score(game)
  game_score = if WIN.include?(game)
                 6
               elsif LOSS.include?(game)
                 0
               else
                 3
               end

  game_score + CHOICE_SCORES[game[1]]
end

def part1(formatted_input)
  translate = { 'X' => 'A', 'Y' => 'B', 'Z' => 'C' }

  formatted_input.map { |s| s.gsub(Regexp.union(translate.keys), translate) }.sum(&method(:compute_score))
end

def part2(formatted_input)
  formatted_input.map do |game|
    case game[1]
    when 'X'
      LOSS.find { |combination| combination.start_with?(game[0]) }
    when 'Y'
      game[0] * 2
    when 'Z'
      WIN.find { |combination| combination.start_with?(game[0]) }
    end
  end.sum(&method(:compute_score))
end

puts part1(format_input)
puts part2(format_input)
