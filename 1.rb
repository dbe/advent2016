class Range
   def each
     if self.first < self.last
       self.to_s=~(/\.\.\./)  ?  last = self.last-1 : last = self.last
       self.first.upto(last)  { |i| yield i}
     else
       self.to_s=~(/\.\.\./)  ?  last = self.last+1 : last = self.last
       self.first.downto(last) { |i|  yield i }
     end
   end
end

def parse_turn(turn)
  return turn[0].to_sym, turn[1..-1].to_i
end

def update_seen(seen, prev_coords, coords)
  puts "In update_seen. seen: #{seen.inspect}"
  puts "prev_coords: #{prev_coords.inspect}"
  puts "coords: #{coords.inspect}"

  first = true

  (prev_coords.x..coords.x).each do |x|
    if not seen[x]
      seen[x] = {}
    end

    (prev_coords.y..coords.y).each do |y|
      puts "In inner loop: x: #{x}, y: #{y}"
      if seen[x][y]
        if first
          first = false
        else
          puts "SEEN IT"
          return Struct.new(:x, :y).new(x, y)
        end
      else
        seen[x][y] = true
      end
    end
  end

  return false
end

turns = gets.chomp.gsub(' ', '').split(',')

coords = Struct.new(:x, :y).new(0,0)
prev_coords = coords.dup
final_coords = nil

facing = 0 
oreo = [
  {R: 1, L: -1},
  {R: -1, L: 1},
  {R: -1, L: 1},
  {R: 1, L: -1},
]

seen = {}

turns.each_with_index do |turn, i|
  direction, magnitude = parse_turn(turn)

  delta = oreo[facing][direction] * magnitude

  if i % 2 == 0
    coords.x += delta
  else
    coords.y += delta
  end

  final_coords = update_seen(seen, prev_coords, coords)
  break if final_coords

  if direction == :R then facing += 1 else facing -= 1 end
  facing %= 4

  prev_coords = coords.dup
end



puts "X: #{final_coords.x}"
puts "Y: #{final_coords.y}"
puts "Distance: #{final_coords.x.abs + final_coords.y.abs}"
