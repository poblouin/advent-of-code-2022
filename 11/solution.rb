require '../input_reader'

def format_input
  InputReader.read.map(&:strip)
end

class Monkey
  attr_reader :id,
              :items,
              :op,
              :mod,
              :monkeys,
              :true_monkey_id,
              :false_monkey_id

  attr_accessor :inspected

  def initialize(input, monkeys)
    @monkeys = monkeys
    @inspected = 0

    parse(input)
  end

  def inspect_items(relief_handler)
    items.each do |item|
      worry =  eval("#{op.call(item.to_s)} #{relief_handler}")
      new_monkey_id = (worry % mod).zero? ? true_monkey_id : false_monkey_id

      monkeys.find { |m| m.id == new_monkey_id }.items.push(worry)
    end

    self.inspected += items.size
    items.clear
  end

  private

  def parse(input)
    @id = input[0].match(/Monkey (\d+)/).captures.first.to_i
    @items = input[1].match(/Starting items: (\d.*)/).captures.flat_map { |i| i.split(',') }
    @op = ->(old) { eval( input[2].match(/Operation: new = (.*)/).captures.first.gsub('old', old)) }
    @mod = input[3].match(/Test: divisible by (\d+)/).captures.first.to_i
    @true_monkey_id = input[4][-1].to_i
    @false_monkey_id = input[5][-1].to_i
  end
end

def solve(formatted_input, rounds, more_relief = false)
  monkeys = []
  formatted_input.each_slice(7).map { |monkey_input| monkeys << Monkey.new(monkey_input, monkeys) }
  relief_handler = more_relief ? "% #{monkeys.map(&:mod).inject(:*)}" : '/ 3'

  rounds.times { monkeys.each { |m| m.inspect_items(relief_handler) } }

  monkeys.map(&:inspected).max(2).inject(:*)
end

# 151312
puts solve(format_input, 20)
# 51382025916
puts solve(format_input, 10_000, true)
