require 'digest'

def main()
  prefix = 'abbhdwsy'
  #prefix = "abc"

  i = 0
  password = ""

  while true
    if(i % 1000000 == 0)
      puts "Iteration: #{i}"
    end

    input = "#{prefix}#{i}" 
    hash_value = Digest::MD5.hexdigest(input)

    if(interesting_hash(hash_value))
      password << extract_password_char(hash_value)
      
      puts "Found char. Password is now: #{password}"

      break if password.length == 8
    end

    i+=1
  end

  puts "Answer: #{password}"
end

def interesting_hash(h)
  return h[0..4] == "00000"
end

def extract_password_char(h)
  return h[5]
end

main()
