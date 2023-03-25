# Knot Hash
#
input = File.read("./inputs/d10.txt").chomp

arr = (0..255).to_a
require "pry"
pos = skip = 0
input = input.bytes.concat([17, 31, 73, 47, 23])

64.times do
  input.each do |len|
    indexes = (pos..pos + len - 1).map { |i| i % arr.length }

    values = indexes.map { |i| arr[i] }.reverse
    indexes.each_with_index { |i, idx| arr[i] = values[idx] }

    pos = (pos + skip + len) % arr.length

    skip += 1
  end
end

hex_dense_hash = arr.each_slice(16).reduce("") do |str, slice|
  substr = slice.reduce(0, :^).to_s(16)
  substr = substr == "0" ? "00" : substr
  str.concat(substr)
end

puts hex_dense_hash
