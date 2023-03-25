# Knot Hash
#
input = File.read("./inputs/d10.txt")

arr = (0..255).to_a

pos = 0
skip = 0
input = input.split(",").map(&:to_i)
input.each do |len|
  indexes = (pos..pos + len - 1).map { |i| i % arr.length }

  values = indexes.map { |i| arr[i] }.reverse
  indexes.each_with_index { |i, idx| arr[i] = values[idx] }

  pos = (pos + skip + len) % arr.length

  skip += 1
end
puts arr[0] * arr[1]
