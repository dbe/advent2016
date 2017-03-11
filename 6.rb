def deduce_message(char_map_by_pos)
  message = ""

  char_map_by_pos.each do |char_map|
    sorted = char_map.sort_by {|char, count| count}
    message << sorted[0][0].to_s
  end

  return message
end

def main
  char_counts_map_by_pos = []

  first_run = true
  while(input = gets.chomp) != ''
    input.length.times do |i|

      if first_run
        char_counts_map_by_pos[i] = {}
      end

      char = input[i]

      char_count = char_counts_map_by_pos[i][char] || 0
      char_counts_map_by_pos[i][char] = char_count + 1
    end

    first_run = false
  end

  puts "Message: #{deduce_message(char_counts_map_by_pos)}"
end

main()
