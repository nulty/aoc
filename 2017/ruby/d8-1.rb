input = File.read("./inputs/d8.txt")
lines = input.split("\n")
registers = {}
messages = { "inc" => :+, "dec" => :- }

lines.each do |line|
  target, instruction, value, _, lhs, compare, rhs = line.split(" ")
  registers[target] ||= 0
  lhs_val = registers[lhs] ||= 0

  if lhs_val.send(compare, Integer(rhs))
    registers[target] = registers[target].send(messages[instruction], Integer(value))
  end
end

puts registers.values.max
