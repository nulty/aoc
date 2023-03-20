input = File.read("./inputs/d6.txt").split(" ").map(&:to_i)

# input = "2 4 1 2".split(" ").map(&:to_i)

require "pry"
seen = { input.to_s => { iterations: 1, times: 1 } }

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

  if seen[input.to_s]
    if seen[input.to_s][:times] > 0
      count = seen[input.to_s][:iterations]
      break
    end

    seen[input.to_s][:times] += 1
  else
    seen[input.to_s] = { iterations: 0, times: 1 }
  end

  seen.each do |_, v|
    v[:iterations] += 1
  end
end

puts count
