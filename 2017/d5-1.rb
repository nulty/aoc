steps = File.read("./inputs/d5.txt").split("\n").map(&:to_i)

pos = 0
jumps = 0

loop do
  break if steps[pos].nil?

  last_pos = pos

  pos += steps[pos]

  steps[last_pos] += 1
  jumps += 1
end

puts jumps
