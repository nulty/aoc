steps = File.read("./inputs/d5.txt").split("\n").map(&:to_i)

pos = 0
jumps = 0

loop do
  break if steps[pos].nil? || pos.negative?

  offset = steps[pos]

  steps[pos] += offset > 2 ? -1 : 1
  pos += offset
  jumps += 1
end

puts jumps
