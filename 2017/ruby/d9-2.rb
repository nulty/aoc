input = File.read("./inputs/d9.txt")

# Counting Garbage
#

cancelled = false
garbage = false

results = input.chars.reduce(0) do |score, c|
  if cancelled
    cancelled = false
    next score
  end

  score += 1 if garbage && !cancelled && !["!", ">"].include?(c)

  case c
  when "!"
    cancelled = true
  when "<"
    garbage = true
  when ">"
    garbage = false
  end
  score
end

puts results
