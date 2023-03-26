input = File.read("../inputs/d12.txt")

hash = {}
seen = []

input.each_line(chomp: true).reduce(hash) do |_h, line|
  a = line.partition(" <-> ")
  hash[a[0]] = a[2].split(", ")
end

def search(hash, seen, idx)
  ids = hash[idx]
  ids.each do |id|
    next if seen.include?(id)

    seen << id
    search(hash, seen, id)
  end
end

search(hash, seen, "0")
puts seen.count
