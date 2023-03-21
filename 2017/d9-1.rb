input = File.read("./inputs/d9.txt")

# Counting Groups - Ingoring Garbage
#
#
# inputs = []
# inputs << "{{<a!>},{<a!>},{<a!>},{<ab>}}"
# inputs << "{{<a!>},{<a!>},{<a!>},{<ab>}}"
# inputs << "{}" # , score of 1.
# inputs << "{{{}}}" # , score of 1 + 2 + 3 = 6.
# inputs << "{{},{}}" # , score of 1 + 2 + 2 = 5.
# inputs << "{{{},{},{{}}}}" # , score of 1 + 2 + 3 + 3 + 3 + 4 = 16.
# inputs << "{<a>,<a>,<a>,<a>}" # , score of 1.
# inputs << "{{<ab>},{<ab>},{<ab>},{<ab>}}" # , score of 1 + 2 + 2 + 2 + 2 = 9.
# inputs << "{{<!!>},{<!!>},{<!!>},{<!!>}}" # , score of 1 + 2 + 2 + 2 + 2 = 9.
# inputs << "{{<a!>},{<a!>},{<a!>},{<ab>}}" # , score of 1 + 2 = 3.

depth = 0
cancelled = false
garbage = false

# results = inputs.map do |puzz|
results = input.chars.reduce(0) do |score, c|
  if cancelled
    cancelled = false
    next score
  end
  cancelled = true if c == "!"
  next score if garbage && c != ">"

  case c
  when ">"
    garbage = false
  when "<"
    garbage = true
  when "{"
    depth += 1
  when "}"
    score += depth
    depth -= 1
  end
  score
end
# end

puts results
