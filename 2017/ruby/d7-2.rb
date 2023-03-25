require "pry"
input = File.read("./inputs/d7.rb")
bottom = "wiapj"

# input = <<~INPUT
#   pbga (66)
#   xhth (57)
#   ebii (61)
#   havc (66)
#   ktlj (57)
#   fwft (72) -> ktlj, cntj, xhth
#   qoyq (66)
#   padx (45) -> pbga, havc, qoyq
#   tknk (41) -> ugml, padx, fwft
#   jptl (61)
#   ugml (68) -> gyxo, ebii, jptl
#   gyxo (61)
#   cntj (57)
# INPUT
# bottom = "tknk"

lines = input.split("\n")

# Generate a hash where key is the name
# and value is hash with weight and children
hash = lines.each_with_object({}) do |p, memo|
  name, weight, children = p.match(/(\w+)\s\((\d+)\).*?([\w, ]+)?$/).captures

  memo[name] = { w: weight.to_i, c: children&.strip&.split(", ") }
end

# Create recursive function to calculate which branch is responsible for the
# imbalance
def compute_weight(hash, name)
  node = hash[name]

  # return early if the current name has no children
  return { name:, weight: node[:w], total: node[:w] } unless node[:c]

  # collect the computed weights for the children
  children = node[:c].map do |c|
    compute_weight(hash, c)
  end

  # if any of the children returned just an integer,
  # it's the answer we need. Just keep returning it
  answer = children.find { |c| c.is_a?(Integer) }
  return answer if answer

  # Get the index of the chidren whose total is different from
  # the others, it there is one.
  # How much difference is there
  # Deduct the difference from the name's weight
  # Return up the stack
  if idx = odd_one_out(children)
    diff = children[idx][:total] - children[idx - 1][:total]
    children[idx][:weight] - diff
  else
    {
      total: children.sum { |c| c[:total] } + node[:w],
      name:,
      weight: node[:w]
    }
  end
end

def odd_one_out(coll)
  result = coll.group_by { |item| item[:total] }.find { |_k, v| v.size == 1 }
  return unless result

  coll.index { |c| c[:total] == result.first }
end

puts compute_weight(hash, bottom)
