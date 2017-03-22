FIRST_REGEX = %r{
  (?: 
    (?: 
      ([a-z]) ([a-z]) (?= (?! \2 )) (\1)
    )
    .*
    (?: \[ .* \2\1\2 .* \])
  )
}x

SECOND_REGEX = %r{
  \[ .* 
    (?: ([a-z])([a-z]) (?= (?! \2)) \1 )
  .* \]
  .*
  \2\1\2

}x

def matches_without_edgecase(input, re)
  #matches = input.to_enum(:scan, re).map { Regexp.last_match }
  matches = input.scan(re)
  puts "Matches: #{matches.inspect}"

  if(matches.length > 0)
    return true
  end

  return false
end

def main()
  count = 0

  while(input = gets.chomp) != ''
    #if(matches_without_edgecase(input, /.*((.)(.)\2).*\[.*\3\2\3.*\].*/)
    if(matches_without_edgecase(input, FIRST_REGEX))
      count += 1
      #puts "First: #{input}"
    #elsif(matches_without_edgecase(input, /\[.*((.)(.)\2).*\].*\3\2\3/))
    elsif(matches_without_edgecase(input, SECOND_REGEX))
      count += 1
      #puts "Second: #{input}"
    end
  end

  puts "Count: #{count}"
end

main()
