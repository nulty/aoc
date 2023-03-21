input = File.read("./inputs/d8.txt")

# input = <<~INPUT
#   b inc 5 if a > 1
#   a inc 1 if b < 5
#   c dec -10 if a >= 1
#   c inc -20 if c == 10
# INPUT

lines = input.split("\n")
registers = {}
messages = { "inc" => :+, "dec" => :- }

max = 0
lines.each do |line|
  target, instruction, value, _, lhs, compare, rhs = line.split(" ")
  registers[target] ||= 0
  lhs_val = registers[lhs] ||= 0
  result = registers[target].send(messages[instruction], Integer(value)) if lhs_val.send(compare, Integer(rhs))
  if result
    max = [result, max].max
    registers[target] = result
  end
end
puts max
