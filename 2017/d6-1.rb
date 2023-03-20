input = File.read("./inputs/d6.txt").split(" ").map(&:to_i)

seen = { input.to_s => true }
count = 0

loop do
  val = max = input.max
  idx = input.index(max)

  input[idx] = 0

  val.times do
    idx = if idx == input.length - 1
            0
          else
            idx + 1
          end
    input[idx] += 1
  end
  count += 1

  break count if seen[input.to_s]

  seen[input.to_s] = true
end

puts count
