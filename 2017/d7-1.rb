require 'pry'

input = File.read('./inputs/d7.rb')

# input = <<-INPUT
# pbga (66)
# xhth (57)
# ebii (61)
# havc (66)
# ktlj (57)
# fwft (72) -> ktlj, cntj, xhth
# qoyq (66)
# padx (45) -> pbga, havc, qoyq
# tknk (41) -> ugml, padx, fwft
# jptl (61)
# ugml (68) -> gyxo, ebii, jptl
# gyxo (61)
# cntj (57)
# INPUT

# The bottom tower must be holding other towers so they must have children. We
# can eliminate all the lines without towers We still don't know what the
# weights are for 
parents = input.split("\n").select { |l| l[/->/] }

h = {}
res = parents.reduce(h) do |memo, p|
  split = p.partition('->')
  
  memo[split[0][/\w+/]] = split[2].strip.split(', ')
  memo
end

bottom = res.keys.find do |name|
  res.values.none? { |arr| arr.include?(name) }
end

puts res
puts bottom
