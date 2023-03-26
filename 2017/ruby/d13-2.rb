# frozen_string_literal: true

input = File.read("../inputs/d13.txt")

sets = input.each_line(chomp: true).each_with_object({}) do |l, h|
  h.store(*l.split(": ").map(&:to_i))
end

def get_pos(step, size, offset = 0)
  step += offset

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

delay = 0
while true
  break delay if sets.all? { |steps, range| get_pos(steps, range, delay).positive? }
  delay += 1
end
puts delay
