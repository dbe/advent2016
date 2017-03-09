def parse_input(input)
  line = input.split('-')
  letter_sections = line[0..-2]

  sector_and_checksum = line[-1].split('[')
  sector_id = sector_and_checksum[0]
  checksum = sector_and_checksum[1][0..-2]

  return letter_sections, sector_id, checksum
end

def create_letter_map(sections)
  map = {}

  sections.each do |section|
    for i in 0..section.length - 1
      letter = section[i]
      count = map[letter] ? map[letter] + 1 : 1
      map[letter] = count
    end
  end

  return map
end

def calculate_checksum(letter_map)
  letter_count_array = []
  letter_map.each do |letter, count|
    letter_count_array << {letter: letter, count: count}
  end

  letter_count_array.sort! do |a, b|
    [b[:count], a[:letter]] <=> [a[:count], b[:letter]]
  end

  return (letter_count_array[0..4].map {|lc| lc[:letter]}).join('')
end


def main
  sector_sum = 0

  while(input = gets.chomp) != ''
    letter_sections, sector_id, checksum = parse_input(input)

    letter_map = create_letter_map(letter_sections)

    actual_checksum = calculate_checksum(letter_map)

    if checksum == actual_checksum
      sector_sum += sector_id.to_i
    end
  end

  puts "Sector sum: #{sector_sum}"
end

main
