def invalid_input?(input)
  invalid = (input =~ /\[[^\]]*(.)(.)\2\1.*\]/)
  puts "Invalid string: #{input}" if invalid

  return invalid
end

def contains_valid_sequence?(input)
  parts = input.split(/\[.*?\]/)
  re = /(.)(.)\2\1/

  parts.each do |part|
    matches = input.to_enum(:scan, re).map { Regexp.last_match }
    matches.each do |match|
      if match[0][0] != match[0][1]
        return true
      end
    end
  end

  return false
end

def main()
  valid_count = 0

  while(input = gets.chomp) != ''
    next if invalid_input?(input)

    valid_count += 1 if contains_valid_sequence?(input)
  end

  puts "Valid Count: #{valid_count}"
end


main()
