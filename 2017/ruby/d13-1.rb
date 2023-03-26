# frozen_string_literal: true

input = File.read("../inputs/d13.txt")

# input = <<~INPUT
#   0: 3
#   1: 2
#   4: 4
#   6: 4
# INPUT
#
sets = input.each_line(chomp: true).each_with_object({}) do |l, h|
  h.store(*l.split(": ").map(&:to_i))
end

def get_pos(step, size)
  max_index = size - 1
  return step if step <= max_index

  div = step / max_index

  if div.zero?
    step
  elsif div.even?
    step % max_index
  elsif div.odd?
    max_index - (step % max_index)
  end
end

puts(sets.reduce(0) do |memo, (steps, range)|
  memo + (get_pos(steps, range).zero? ? steps * range : 0)
end)
