input = File.read("../inputs/d12.txt")
hash = {}

input.each_line(chomp: true).reduce(hash) do |_h, line|
  a = line.partition(" <-> ")
  hash[a[0]] = a[2].split(", ")
end

groups = 0
def create_group(hash, key)
  hash.delete(key)&.each do |val|
    create_group(hash, val)
  end
end
until hash.keys.empty?
  create_group(hash, hash.keys.first)
  groups += 1
end
puts groups
