def is_valid_triangle(lengths)
  max = lengths.max
  lengths.delete_at(lengths.find_index(max))

  return lengths[0] + lengths[1] > max
end

valid_count = 0
line = 1
triangles = []
buffers = [[],[],[]]

while(input = gets.chomp) != ''
  #For part 1
  #lengths = input.split(' ').map! { |i| i.to_i }
  lengths = input.split(' ').map! { |i| i.to_i }
  buffers[0] << lengths[0]
  buffers[1] << lengths[1]
  buffers[2] << lengths[2]

  if line % 3 == 0
    triangles << buffers[0]
    triangles << buffers[1]
    triangles << buffers[2]
    buffers = [[],[],[]]
  end

  line += 1
end

triangles.each do |t|
  if is_valid_triangle(t)
    valid_count += 1
  end
end

puts "Valid Count: #{valid_count}"
