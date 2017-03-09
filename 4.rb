ALPHABET = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

def parse_input(input)
  line = input.split('-')
  letter_sections = line[0..-2]

  sector_and_checksum = line[-1].split('[')
  sector_id = sector_and_checksum[0].to_i
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

def decypher(letter_sections, sector_id)
  shift_amount = sector_id % 26
  
  letter_sections.each do |section|
    for i in 0..section.length - 1
      index = ALPHABET.index(section[i])
      index += shift_amount
      index %= 26
      section[i] = ALPHABET[index]
    end
  end

  return letter_sections.join(' ')
end


def main
  sentence_sector_array = []

  while(input = gets.chomp) != ''
    letter_sections, sector_id, checksum = parse_input(input)
    letter_map = create_letter_map(letter_sections)
    actual_checksum = calculate_checksum(letter_map)

    if checksum == actual_checksum
      sentence_sector_array << {sentence: decypher(letter_sections, sector_id), sector: sector_id}
    end
  end

  sentence_sector_array.each do |ss|
    puts "#{ss[:sentence]} -- #{ss[:sector]}"
  end
end

main
