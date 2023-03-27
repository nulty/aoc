input = "hwlqcszp"
# input = "flqrgnkx"

# Each row is a knot hash of length 128
# the knot hash outputs a 32 bit hex string
# convert each bit to binary
# count the number of 1 in the binary for each row

def hash(input)
  output = (0..255).to_a
  pos = skip = 0

  64.times do
    input.codepoints.concat([17, 31, 73, 47, 23]).each do |len|
      indexes = (pos..pos + len - 1).map { |i| i % output.length }
      values = indexes.map { |i| output[i] }.reverse
      indexes.each_with_index { |i, idx| output[i] = values[idx] }
      pos = (pos + skip + len) % output.length
      skip += 1
    end
  end

  output.each_slice(16).reduce(String.new) do |str, slice|
    substr = format("%.2x", slice.reduce(0, :^))
    binary = substr.chars.map { |c| format("%.4b", c.to_i(16)) }.join
    str.concat(binary)
  end
end

result = (0..127).map do |n|
  hash("#{input}-#{n}").tr('1','#').tr('0', '.')
end

puts result.join.length
puts result.join
puts result.join.chars.count("#")
